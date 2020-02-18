# frozen_string_literal: true

# == Schema Information
#
# Table name: mches
#
#  id         :bigint           not null, primary key
#  c1         :string(255)
#  c2         :string(255)
#  c3         :string(255)
#  c4         :string(255)
#  code       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Mch < ApplicationRecord
  has_many :category_mches
  # HEADER: Excel表的標題行
  HEADER = %w[MCH 大類名稱 中類名稱 小類名稱 大類 中類 小類].freeze

  # Mch.import_sheets('example.xlsx')
  def self.import_sheets(file_name)
    handler = ImportSheets::Mch.new(self, file_name).sty_flow
    handler.each { |item| find_or_create_by!(item) }
  end
end
