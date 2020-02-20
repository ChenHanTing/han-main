# frozen_string_literal: true

class ImportSheets::CategoryMch < ImportSheets::Base
  def initialize(cls, file_name, mch, category)
    super(cls, file_name)
    @mch = mch
    @cat = category
  end

  def sty_category_mch_handler
    code = sty_raw_data.values[0..3]
    path = sty_raw_data.values[4..6]
    return if code.nil? || path.nil?
    return if code.any?(&:nil?) || path.any?(&:nil?)
    return if path.any? { |e| ['#REF!', '#NA'].include?(e) }

    sty_data_handler = { code: code, path: path }

    @cls.find_or_create_by!(
      mch: @mch.find_by(code: sty_data_handler[:code].join('')),
      category: @cat.find_by(path: sty_data_handler[:path].join('/'))
    )
  end
end
