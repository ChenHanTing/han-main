# frozen_string_literal: true

class Importsheets
  include Import::Sheets::Strategy

  def initialize(cls, file_name)
    @demo = 'DEMO INFORMATION'
    @cls = cls
    @file_name = file_name
    # In rails convention, the first col always place `id`,
    # and the last two cols always place 'updated at' & `created at`
    @db_cols = cls.column_names[1..-3].map(&:to_sym) if cls.present?
  end

  def print_info
    puts "print: #{@demo}"
  end

  # 匯入 excel 到資料庫的流程
  # 預設流程為 strategy.rb 內的 DEFAULT_STRATEGY
  # 若要自訂定流程，請在 model內寫入 STRATEGY
  def sty_flow
    sty_init
    get_sty_flow.each do |k, v|
      go_method = "sty_#{@cls.to_s.downcase}_#{k}".to_sym
      go_method = v unless respond_to?(go_method)
      send(go_method) if go_method.present?
    end

    sty_data_handler
  end

  # Custom code
  #
  # Category
  def sty_category_handler
    sty_demo_info
    self.sty_data_handler = []

    @cls::HEADER.each_with_index do |i, idx| # (0, 1, 2)
      # db columns: [:name, :path, :parent_id]
      # first column => name
      # second column => path
      sty_raw_data.each do |j|
        first = @db_cols.first
        second = @db_cols.second
        name = j[i.to_s]
        path = j.values[0..idx].join('/')

        sty_data_handler.append(first => name, second => path) if name.present?
      end
    end

    sty_data_handler.uniq!
  end

  # Mch
  def sty_mch_handler
    sty_demo_info
    self.sty_data_handler = []
    c1, c2, c3, c4, cs = @db_cols

    sty_raw_data.each do |ele|
      next if ele['MCH'].nil?

      code = [ele['MCH'], ele['大類'], ele['中類'], ele['小類']]
      data = { c1 => ele['MCH'],
               c2 => ele['大類名稱'],
               c3 => ele['中類名稱'],
               c4 => ele['小類名稱'],
               cs => code.join('') }

      # 0, 1, 2, 3
      # 注意有雷：當key異動時，sty_data_handler的key也會跟著異動
      # 解決方法：先轉成陣列（line 79），再轉為hash(line 85)
      (0..3).each do |i|
        unless i.zero?
          code[(4 - i)] = nil
          data[:"c#{5 - i}"] = nil
          data[:cs] = code.join('')
        end

        sty_data_handler.append(data.to_a)
      end
    end

    sty_data_handler.uniq!
    sty_data_handler.map!(&:to_h)
  end

  def sty_demo_info
    puts 'HELLO, I AM DATA HANDLER'
    puts "DB COLUMN: #{@db_cols}"
  end
end
