# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  name       :string(255)
#  path       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  parent_id  :integer
#

class Category < ApplicationRecord
  include Import::Sheets::Strategy

  # 欲處理的欄位寫進HEADER
  HEADER = {
    'EC-大分類': 'ec_big',
    'EC-中分類': 'ec_medium',
    'EC-小分類': 'ec_small'
  }.freeze

  belongs_to :parent, class_name: 'Category', foreign_key: 'parent_id', optional: true
  has_many :children, class_name: 'Category', foreign_key: 'parent_id'
  has_many :grandchildren, through: :children, source: :children

  # Category.new.demo_cls
  def demo_cls
    Flow.demo_flow
  end

  # Category.new.sty_flow('example.xlsx')
  def sty_flow(file_name)
    strategy_sheets(file_name)
    strategy_columns(self)
    strategy_array
    binding.pry
  end
end
