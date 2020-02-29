# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CategoryMch, type: :model do
  let(:file_name) { './spec/support/files/import_sheets/ex02.xlsx' }

  describe '.import_sheets' do
    context 'check records' do
      it 'creates CategoryMch' do
        Mch.import_sheets(file_name)
        Category.import_sheets(file_name)
        CategoryMch.import_sheets(file_name)

        category_mch = CategoryMch.find_by(
          mch: Mch.find_by(code: '999AAABBB'),
          category: Category.find_by(path: '大/中/小')
        )

        expect(category_mch.nil?).to eq(false)
      end
    end
  end
end
