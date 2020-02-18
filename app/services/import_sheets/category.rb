# frozen_string_literal: true

class ImportSheets::Category < ImportSheets::Base
  def sty_category_handler
    sty_demo_info
    self.sty_data_handler = []

    @cls::HEADER.each_with_index do |i, idx| # (0, 1, 2)
      # db columns: [:name, :path, :parent_id]
      # first column => name
      # second column => path
      sty_raw_data.each do |j|
        name = j[i.to_s]
        next unless name.present?

        sty_data_handler.append(description: name, path: j.values[0..idx].join('/'))
      end
    end

    sty_data_handler.uniq!
  end
end
