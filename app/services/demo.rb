# frozen_string_literal: true

class Demo
  include Import::Sheets::Strategy

  def initialize
    @demo = 'DEMO INFORMATION'
  end

  def print_info
    puts "print: #{@demo}"
  end
end
