# frozen_string_literal: true

module Import
  module Sheets
    module Strategy
      attr_accessor :sty_demo, :info

      def demo_method
        self.sty_demo = 'TEST!'
      end

      # Define default strategy

      DEFAULT_STRATEGY = {
        sheets: :strategy_sheets,
        columns: :strategy_columns,
        build_data: :strategy_array,
        handler: nil
      }.freeze

      # If there is no custom strategy then use default strategy
      def get_sty_flow
        return self.class::STRATEGY if self.class.const_defined?(:STRATEGY)

        DEFAULT_STRATEGY
      end

      def sty_flow(action)
        # k: key of strategy
        # v: value of strategy
        get_sty_flow.each do |k, v|
          go_method = "sty_#{action}_#{k}".to_sym
          go_method = v unless respond_to?(go_method)
          send(go_method) if go_method.present?
        end
      end

      # output example
      # ["example.xlsx", ["s1", "s2", "s3", "s4", "s5", "s6"]]
      def strategy_sheets(file_name)
        self.info = init_deep_hash
        spreadsheet = open_spreadsheet(file_name)

        # first: file name
        # second: file sheets' name
        info[:sheet_info] = [file_name, spreadsheet.sheets]
      end

      # output example
      # {"s4"=>["EC-大分類", "EC-中分類", "EC-小分類"], "s5"=>["EC-大分類", "EC-中分類", "EC-小分類"]}
      def strategy_columns(obj)
        # first: file name
        # second: file sheets' name
        # value: The value to return
        file_name = info[:sheet_info].first
        sheets = info[:sheet_info].second
        spreadsheet = open_spreadsheet(file_name)
        sheets.each do |sheet|
          next if spreadsheet.sheet(sheet).first_row.nil?

          header = obj.class::HEADER if defined? obj.class::HEADER

          if header.present?
            column = spreadsheet.sheet(sheet).row(1) & header.keys.map!(&:to_s)
          else
            info[:column_info].merge!(Hash[sheet, spreadsheet.sheet(sheet).row(1)])
            next
          end

          if column != [] && header.present?
            info[:column_info].merge!(Hash[sheet, column])
          end
        end
      end

      # file_info example
      # ["example.xlsx", ["s1", "s2", "s3", "s4", "s5", "s6"]]

      # sheet_info example
      # {"s4"=>["EC-大分類", "EC-中分類", "EC-小分類"], "s5"=>["EC-大分類", "EC-中分類", "EC-小分類"]}

      # Mch.new.sty_flow('example.xlsx')
      # def sty_flow(file_name)
      #   sheet_info = strategy_sheets(file_name)
      #   column_info = strategy_columns(self, sheet_info)
      #   data = strategy_array(sheet_info, column_info)
      # end
      def strategy_array
        info[:data] = []

        sheet_info = info[:sheet_info]
        column_info = info[:column_info]
        spreadsheet = open_spreadsheet(sheet_info.first)
        column_info.each do |sheet, column|
          (2..spreadsheet.last_row).each do |i|
            header = spreadsheet.sheet(sheet).row(1)
            puts Hash[[header, spreadsheet.row(i)].transpose].slice(*column).to_s
            info[:data].append(Hash[[header, spreadsheet.row(i)].transpose].slice(*column))
          end
        end

        info[:data].uniq!
      end

      # for background
      def open_spreadsheet(file_name)
        file_path = File.expand_path(file_name)
        file = File.open(file_path)

        case File.extname(file)
        when '.csv' then Roo::Csv.new(file.path)
        when '.xls' then Roo::Excel.new(file.path)
        when '.xlsx' then Roo::Excelx.new(file.path)
        else raise "Unknown file type: #{file}"
        end
      end

      def init_deep_hash
        Hash.new { |h, k| h[k] = Hash.new(&h.default_proc) }
      end

      def sty_action
        sty[:current_action]
      end

      class Flow
        def self.demo_flow
          puts 'First flow.'
        end
      end
    end
  end
end
