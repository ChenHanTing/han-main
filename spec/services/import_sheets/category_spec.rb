# frozen_string_literal: true

require 'rails_helper'

module ImportSheets
  RSpec.describe Category do
    let(:file_name) { './spec/support/files/import_sheets/ex02.xlsx' }
    let(:base) { ImportSheets::Category.new(::Category, file_name) }
    let(:file) { File.open(file_name) }
    let(:header) { %w[EC-大分類 EC-中分類 EC-小分類] }

    describe '#sty_flow' do
      context 'category sheet import testing' do
        it 'should successfully run strategy flow from the given excel' do
          base.sty_flow
          expect(base.sty_column_info.keys).to eq(['s0'])
          expect(base.sty_column_info['s0'] - header).to eq([])
        end

        it 'should fetch right result from the given excel' do
          base.sty_flow
          expect(base.sty_raw_data).to eq(
            'EC-大分類' => '大',
            'EC-中分類' => '中',
            'EC-小分類' => '小'
          )
        end
      end
    end
  end
end
