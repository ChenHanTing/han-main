# frozen_string_literal: true

class ImportSheets::CheckSheetsInfo < ImportSheets::Base
  def sty_check_sheets_info_handler
    self.sty_data_handler = []

    sty_raw_data.each do |item|
      code = [item['MCH'], item['大類'], item['中類'], item['小類']]
      path = [item['EC-大分類'], item['EC-中分類'], item['EC-小分類']]
      mch_path = [item['MCH'], item['大類名稱'], item['中類名稱'], item['小類名稱']]
      sty_data_handler.append(code: code.join(''),
                              path: path.join('/'),
                              mch_path: mch_path.join('/'),
                              detail: item.to_json)
    end

    sty_data_handler
  end
end
