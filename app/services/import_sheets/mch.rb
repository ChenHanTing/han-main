# frozen_string_literal: true

class ImportSheets::Mch < ImportSheets::Base
  def sty_mch_handler
    sty_demo_info

    self.sty_data_handler = []

    return if sty_raw_data['MCH'].nil?

    code = [sty_raw_data['MCH'].to_s,
            sty_raw_data['大類'].to_s,
            sty_raw_data['中類'].to_s,
            sty_raw_data['小類'].to_s]

    path = [sty_raw_data['EC-大分類'],
            sty_raw_data['EC-中分類'],
            sty_raw_data['EC-小分類']]

    data = {
      c1: sty_sheet,
      c2: sty_raw_data['大類名稱'],
      c3: sty_raw_data['中類名稱'],
      c4: sty_raw_data['小類名稱'],
      code: code.join(''),
      path: path
    }

    # 0, 1, 2, 3
    # 注意有雷：當key異動時，sty_data_handler的key也會跟著異動
    # 解決方法：先轉成陣列（line 79），再轉為hash(line 85)
    (0..3).each do |i|
      unless i.zero?
        path = nil
        code[(4 - i)] = nil
        data[:"c#{5 - i}"] = nil
        data[:code] = code.join('')
      end

      sty_data_handler.append(data.to_a)
    end

    sty_data_handler.map!(&:to_h).each { |item| @cls.find_or_create_by!(item) }
  end
end
