# frozen_string_literal: true

class MchSheets < Import::Sheets
  def sty_mch_handler
    sty_demo_info
    self.sty_data_handler = []

    sty_raw_data.each do |ele|
      next if ele['MCH'].nil?

      code = [ele['MCH'], ele['大類'], ele['中類'], ele['小類']]
      data = { c1: ele['MCH'],
               c2: ele['大類名稱'],
               c3: ele['中類名稱'],
               c4: ele['小類名稱'],
               code: code.join('') }

      # 0, 1, 2, 3
      # 注意有雷：當key異動時，sty_data_handler的key也會跟著異動
      # 解決方法：先轉成陣列（line 79），再轉為hash(line 85)
      (0..3).each do |i|
        unless i.zero?
          code[(4 - i)] = nil
          data[:"c#{5 - i}"] = nil
          data[:code] = code.join('')
        end

        sty_data_handler.append(data.to_a)
      end
    end

    sty_data_handler.uniq!
    sty_data_handler.map!(&:to_h)
  end
end
