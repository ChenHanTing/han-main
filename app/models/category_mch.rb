# frozen_string_literal: true

# == Schema Information
#
# Table name: category_mches
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint
#  mch_id      :bigint
#
# Indexes
#
#  index_category_mches_on_category_id  (category_id)
#  index_category_mches_on_mch_id       (mch_id)
#

class CategoryMch < ApplicationRecord
  belongs_to :category, optional: true
  belongs_to :mch, optional: true

  # 不需要，因為有 belongs_to
  # validates_presence_of :category_id
  # validates_presence_of :mch_id

  HEADER = %w[EC-大分類 EC-中分類 EC-小分類 MCH 大類 中類 小類].freeze

  # CategoryMch.import_sheets('example.xlsx')
  def self.import_sheets(file_name)
    ImportSheets::CategoryMch.new(self, file_name, Mch, Category).sty_flow
  end
end
