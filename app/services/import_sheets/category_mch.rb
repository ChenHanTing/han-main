# frozen_string_literal: true

class ImportSheets::CategoryMch < ImportSheets::Base
  def sty_category_mch_handler
    self.sty_data_handler = []

    sty_raw_data.each do |i|
      code = i.values[0..3]
      path = i.values[4..6]
      next if code.nil? || path.nil?
      next if code.any?(&:nil?) || path.any?(&:nil?)
      next if path.any? { |e| ['#REF!', '#NA'].include?(e) }

      sty_data_handler.append(code: code, path: path)
    end

    sty_data_handler.uniq!
  end
end
