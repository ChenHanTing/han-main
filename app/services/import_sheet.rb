# frozen_string_literal: true

class ImportSheet
  include Import::Sheets::Strategy

  def initialize(file)
    @file = file
  end

  def demo
    demo_method
    puts %(sty_demo = #{sty_demo})
  end
end
