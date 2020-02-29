# frozen_string_literal: true

module ImportSheets
  module Strategy
    attr_accessor :sty_info

    # Define default strategy
    # It would be valid if you want to write custom strategy in model.
    DEFAULT_STRATEGY = {
      sheets: :strategy_sheets,
      columns: :strategy_columns,
      data: :strategy_data
    }.freeze

    DEFAULT_DATA_STRATEGY = {
      raw: :strategy_raw,
      handler: nil
    }.freeze

    def sty_flow
      self.sty_info = init_deep_hash
      get_sty_flow.each do |k, v|
        go_method = "sty_#{@cls.to_s.underscore}_#{k}".to_sym
        go_method = v unless respond_to?(go_method)
        send(go_method) if go_method.present?
      end
    end

    def sty_inner_flow
      get_sty_inner_flow.each do |k, v|
        go_method = "sty_#{@cls.to_s.underscore}_#{k}".to_sym
        go_method = v unless respond_to?(go_method)
        send(go_method) if go_method.present?
      end
    end

    def sty_init
      self.sty_info ||= init_deep_hash
    end

    # If there is no custom strategy, it will run default strategy
    def get_sty_flow
      return self.class::STRATEGY if self.class.const_defined?(:STRATEGY)

      DEFAULT_STRATEGY
    end

    # If there is no custom strategy, it will run default strategy
    def get_sty_inner_flow
      return self.class::STRATEGY if self.class.const_defined?(:DATA_STRATEGY)

      DEFAULT_DATA_STRATEGY
    end

    # output example
    # ["example.xlsx", ["s1", "s2", "s3", "s4", "s5", "s6"]]
    def strategy_sheets
      spreadsheet = open_spreadsheet(@file_name)
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

    def strategy_data
      sheet_info = sty_sheet_info
      column_info = sty_column_info
      spreadsheet = open_spreadsheet(sheet_info.first)

      column_info.each do |sheet, column|
        (2..spreadsheet.last_row).each do |element|
          self.sty_sheet = sheet
          self.sty_file = spreadsheet
          self.sty_ele = element
          self.sty_col = column

          sty_inner_flow
        end
      end
    end

    def strategy_raw
      self.sty_raw_data =
        Hash[[sty_file.sheet(sty_sheet).row(1), sty_file.row(sty_ele)]
        .transpose]
        .slice(*sty_col)
    end

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

    def init_deep_hash
      Hash.new { |h, k| h[k] = Hash.new(&h.default_proc) }
    end

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

    def sty_ele
      sty_info[:ele]
    end

    def sty_ele=(ele)
      sty_info[:ele] = ele
    end

    def sty_col
      sty_info[:col]
    end

    def sty_col=(col)
      sty_info[:col] = col
    end

    def sty_sheet
      sty_info[:sheet]
    end

    def sty_sheet=(sheet)
      sty_info[:sheet] = sheet
    end

    def sty_file
      sty_info[:file]
    end

    def sty_file=(file)
      sty_info[:file] = file
    end
  end
end
