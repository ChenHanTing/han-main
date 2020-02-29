# frozen_string_literal: true

class ImportSheets::Category < ImportSheets::Base
  def initialize(cls, file_name)
    super(cls, file_name)
  end

  def sty_category_raw
    self.sty_raw_data =
      Hash[
        [sty_file.sheet(sty_sheet).row(1),
         sty_file.row(sty_ele)].transpose
      ].slice(*sty_col)
  end

  def sty_category_handler
    @cls::HEADER.each_with_index do |i, idx|
      name = sty_raw_data[i.to_s]
      next if name.nil?

      parent = @cls.find_by(path: sty_raw_data.values[0...idx].join('/'))
      parent ||= @cls.find_by(description: '自訂商品目錄')

      @cls.find_or_create_by!(
        description: name,
        parent: parent,
        path: sty_raw_data.values[0..idx].join('/')
      )
    end
  end
end
