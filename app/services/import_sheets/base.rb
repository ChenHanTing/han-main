# frozen_string_literal: true

class ImportSheets::Base
  include ImportSheets::Strategy

  def initialize(cls, file_name)
    @cls = cls
    @file_name = file_name
  end
end
