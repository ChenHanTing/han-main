# frozen_string_literal: true

class ImportSheets::CategoryMch < ImportSheets::Base
  def sty_category_mch_handler
    self.sty_data_handler = []

    sty_raw_data.each do |i|
      code = i.values[0..3].join('')
      path = i.values[4..6].join('/')
      next if code.blank? || path.blank?

      sty_data_handler.append(code: code, path: path)
    end

    sty_data_handler.uniq!
  end
end
