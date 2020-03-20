# frozen_string_literal: true

module ImportSheets
  class Promotion < Base
    STRATEGY = {
      sheets: :strategy_sheets,
      columns: :strategy_columns,
      build_data: :strategy_array,
      handler: nil
    }.freeze

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
        end
        sty_raw_data.uniq!
      end
    end

    def sty_items_imports_controller_handler
      self.sty_data_handler = sty_raw_data.map do |d|
        { content: d.values.first }
      end
    end
  end
end