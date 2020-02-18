# frozen_string_literal: true

class Import::Sheets
  include Import::Strategy

  def initialize(cls, file_name)
    @demo = 'DEMO INFORMATION'
    @cls = cls
    @file_name = file_name
  end

  def print_info
    puts "print: #{@demo}"
  end

  # 匯入 excel 到資料庫的流程
  # 預設流程為 strategy.rb 內的 DEFAULT_STRATEGY
  # 若要自訂定流程，請在 <name>_sheets.rb 內寫入 STRATEGY
  def sty_flow
    sty_init
    get_sty_flow.each do |k, v|
      go_method = "sty_#{@cls.to_s.downcase}_#{k}".to_sym
      go_method = v unless respond_to?(go_method)
      send(go_method) if go_method.present?
    end

    sty_data_handler
  end

  def sty_demo_info
    puts 'HELLO, I AM DATA HANDLER'
  end
end
