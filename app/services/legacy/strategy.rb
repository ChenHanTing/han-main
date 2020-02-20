# frozen_string_literal: true

module ImportSheets
  module Strategy
    attr_accessor :sty_demo, :sty_info

    # This is for demo
    def demo_method
      self.sty_demo = 'TEST!'
    end

    # Define default strategy
    # It would be valid if you want to write custom strategy in model.
    DEFAULT_STRATEGY = {
      sheets: :strategy_sheets,
      columns: :strategy_columns,
      build_data: :strategy_array,
      handler: nil
    }.freeze

    # Initialize `self.sty_info`
    def sty_init
      self.sty_info ||= init_deep_hash
    end

    # If there is no custom strategy, it will run default strategy
    def get_sty_flow
      return self.class::STRATEGY if self.class.const_defined?(:STRATEGY)

      DEFAULT_STRATEGY
    end

    # output example
    # ["example.xlsx", ["s1", "s2", "s3", "s4", "s5", "s6"]]
    def strategy_sheets
      spreadsheet = open_spreadsheet(@file_name)

      # first: file name
      # second: file sheets' name
      self.sty_sheet_info = [@file_name, spreadsheet.sheets]
    end

    # output example
    # {"s4"=>["EC-大分類", "EC-中分類", "EC-小分類"], "s5"=>["EC-大分類", "EC-中分類", "EC-小分類"]}
    def strategy_columns
      file_name = sty_sheet_info.first
      sheets = sty_sheet_info.second
      spreadsheet = open_spreadsheet(file_name)
      sheets.each do |sheet|
        next if spreadsheet.sheet(sheet).first_row.nil?

        header = @cls::HEADER if defined? @cls::HEADER

        if header.present?
          column = spreadsheet.sheet(sheet).row(1) & header
        else
          sty_column_info.merge!(Hash[sheet, spreadsheet.sheet(sheet).row(1)])
          next
        end

        if column != [] && header.present?
          sty_column_info.merge!(Hash[sheet, column])
        end
      end
    end

    def strategy_array
      self.sty_raw_data = []

      sheet_info = sty_sheet_info
      column_info = sty_column_info
      spreadsheet = open_spreadsheet(sheet_info.first)

      column_info.each do |sheet, column|
        (2..spreadsheet.last_row).each do |i|
          header = spreadsheet.sheet(sheet).row(1)

          sty_raw_data
            .append(Hash[[header, spreadsheet.row(i)].transpose]
            .slice(*column))

          # 比較直接存與先存進hash再存進DB的資料筆數差異
          # @cls.find_or_create_by!(detail: Hash[[header, spreadsheet.row(i)].transpose].to_json)
        end
      end

      sty_raw_data.uniq!
    end

    # The following method is run for background

    # The method is to open designated file.
    # The method will raise the error if the file extension isn't csv/xls/xlsx
    def open_spreadsheet(file_name)
      file_path = File.expand_path(file_name)
      file = File.open(file_path)

      case File.extname(file)
      when '.csv' then Roo::Csv.new(file.path)
      when '.xls' then Roo::Excel.new(file.path)
      when '.xlsx' then Roo::Excelx.new(file.path)
      else raise "Unknown file type: #{file_name}"
      end
    end

    # Initialize the hash
    #
    # a = Hash.new { |h, k| h[k] = Hash.new(&h.default_proc) }
    # a[:b] = 1
    # a           # =>  {:b => 1}
    # a[:b] = Hash.new { |h, k| h[k] = Hash.new(&h.default_proc) }
    # a           # => {:b => {}}
    # a[:b][:b] = 2
    # a           # => {:b => {:b => 2}}
    def init_deep_hash
      Hash.new { |h, k| h[k] = Hash.new(&h.default_proc) }
    end

    # The following is getter and setter
    # Ruby Getters and Setters
    # ref: https://dev.to/k_penguin_sato/ruby-getters-and-setters-1p30
    def sty_sheet_info
      sty_info[:sheet_info]
    end

    def sty_sheet_info=(sheet_info)
      sty_info[:sheet_info] = sheet_info
    end

    def sty_column_info
      sty_info[:column_info]
    end

    def sty_column_info=(column_info)
      sty_info[:column_info] = column_info
    end

    def sty_raw_data
      sty_info[:raw_data]
    end

    def sty_raw_data=(raw_data)
      sty_info[:raw_data] = raw_data
    end

    def sty_data_handler
      sty_info[:data_handler]
    end

    def sty_data_handler=(data_handler)
      sty_info[:data_handler] = data_handler
    end

    # This is for demo.
    class Flow
      def self.demo_flow
        puts 'First flow.'
      end
    end
  end
end
