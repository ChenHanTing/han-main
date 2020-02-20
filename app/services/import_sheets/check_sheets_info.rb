# frozen_string_literal: true

class ImportSheets::CheckSheetsInfo < ImportSheets::Base
  def sty_check_sheets_info_handler
    code = [sty_raw_data['MCH'], sty_raw_data['大類'], sty_raw_data['中類'], sty_raw_data['小類']]
    path = [sty_raw_data['EC-大分類'], sty_raw_data['EC-中分類'], sty_raw_data['EC-小分類']]
    mch_path = [sty_raw_data['MCH'], sty_raw_data['大類名稱'], sty_raw_data['中類名稱'], sty_raw_data['小類名稱']]
    sty_data_handler = {
      code: code.join(''),
      path: path.join('/'),
      mch_path: mch_path.join('/'),
      detail: sty_raw_data.to_json
    }

    @cls.find_or_create_by!(sty_data_handler)
  end
end
