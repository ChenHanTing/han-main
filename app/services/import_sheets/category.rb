# frozen_string_literal: true

class ImportSheets::Category < ImportSheets::Base
  def sty_category_handler
    sty_demo_info
    self.sty_data_handler = []

    @cls::HEADER.each_with_index do |i, idx| # (0, 1, 2)
      # db columns: [:name, :path, :parent_id]
      # first column => name
      # second column => path
      name = sty_raw_data[i.to_s]
      next unless name.present?

      sty_data_handler.append(description: name, path: sty_raw_data.values[0..idx].join('/'))
    end

    sty_data_handler.each do |item|
      parent = @cls.find_by(path: item.dig(:path).split('/')[0...-1].join('/'))
      parent ||= @cls.find_by(description: '自訂商品目錄')
      @cls.find_or_create_by!(item.merge!(parent: parent))
    end
  end
end
