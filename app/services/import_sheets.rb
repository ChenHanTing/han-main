# frozen_string_literal: true

class Importsheets
  include Import::Sheets::Strategy

  def initialize(cls, file_name)
    @demo = 'DEMO INFORMATION'
    @cls = cls
    @file_name = file_name
  end

  def print_info
    puts "print: #{@demo}"
  end

  def sty_flow
    sty_init
    get_sty_flow.each do |k, v|
      go_method = "sty_#{@cls.to_s.downcase}_#{k}".to_sym
      go_method = v unless respond_to?(go_method)
      send(go_method) if go_method.present?
    end
  end
end
