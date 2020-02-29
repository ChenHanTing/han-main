# frozen_string_literal: true

class ImportSheets::Mch < ImportSheets::Base
  def sty_mch_handler
    return if sty_raw_data['MCH'].nil?

    code = [sty_raw_data['MCH'].to_s,
            sty_raw_data['大類'].to_s,
            sty_raw_data['中類'].to_s,
            sty_raw_data['小類'].to_s]

    data = {
      c1: sty_sheet,
      c2: sty_raw_data['大類名稱'],
      c3: sty_raw_data['中類名稱'],
      c4: sty_raw_data['小類名稱'],
      code: code.join('')
    }

    (0..3).each do |i|
      unless i.zero?
        code[(4 - i)] = nil
        data[:"c#{5 - i}"] = nil
        data[:code] = code.join('')
      end

      @cls.find_or_create_by!(data)
    end
  end
end
