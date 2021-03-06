# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id          :bigint           not null, primary key
#  description :string(255)
#  path        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  parent_id   :integer
#

class Category < ApplicationRecord
  # 欲處理的欄位寫進HEADER
  HEADER = %w[EC-大分類 EC-中分類 EC-小分類].freeze

  belongs_to :parent, class_name: 'Category', foreign_key: 'parent_id', optional: true
  has_many :children, class_name: 'Category', foreign_key: 'parent_id'
  has_many :grandchildren, through: :children, source: :children
  has_many :category_mches

  # Category.new.demo_cls
  def demo_cls
    Flow.demo_flow
  end

  def self.seed
    find_or_create_by!(description: '自訂商品目錄')
    find_or_create_by!(description: '其他目錄')
  end

  # Category.import_sheets('example.xlsx')
  def self.import_sheets(file_name)
    ImportSheets::Category.new(self, file_name).sty_flow
  end
end
