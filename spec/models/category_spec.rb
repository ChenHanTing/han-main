# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:file_name) { './spec/support/files/import_sheets/ex02.xlsx' }

  describe '.import_sheets' do
    context 'check records' do
      it 'creates category' do
        Category.import_sheets(file_name)

        content01 = Category.find_by(
          path: '大',
          description: '大',
          parent: Category.find_by(description: '自訂商品目錄')
        )

        content02 = Category.find_by(
          path: '大/中',
          description: '中',
          parent: Category.find_by(path: '大')
        )

        content03 = Category.find_by(
          path: '大/中/小',
          description: '小',
          parent: Category.find_by(path: '大/中')
        )

        expect(content01.nil?).to eq(false)
        expect(content02.nil?).to eq(false)
        expect(content03.nil?).to eq(false)
      end
    end
  end
end
