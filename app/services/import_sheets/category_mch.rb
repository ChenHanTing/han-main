# frozen_string_literal: true

class ImportSheets::CategoryMch < ImportSheets::Base
  def initialize(cls, file_name, mch, category)
    super(cls, file_name)
    @mch = mch
    @category = category
  end

  def sty_category_mch_handler
    code = sty_raw_data.values[0..3]
    path = sty_raw_data.values[4..6]

    # If the content itself is nil?
    return if code.nil? || path.nil?
    # If the element in array is nil?
    # example: ['中文書', '簡體書', nil]
    # The example above is invalid.
    return if code.any?(&:nil?) || path.any?(&:nil?)

    sty_data_handler = { code: code, path: path }

    mch = @mch.find_by(code: sty_data_handler[:code].join(''))
    category = @category.find_by(path: sty_data_handler[:path].join('/'))
    return if mch.nil? || category.nil?

    @cls.find_or_create_by!(mch: mch, category: category)
  end
end
