# frozen_string_literal: true

require 'rails_helper'

module ImportSheets
  RSpec.describe CategoryMch do
    let(:file_name) { './spec/support/files/import_sheets/ex02.xlsx' }
    let(:file) { File.open(file_name) }
    let(:header) { %w[MCH 大類 中類 小類 EC-大分類 EC-中分類 EC-小分類] }
    let(:base) do
      ImportSheets::CategoryMch.new(::CategoryMch, file_name, ::Mch, ::Category)
    end

    describe '#sty_flow' do
      context 'category-mch sheet import testing' do
        it 'should successfully run strategy flow from the given excel' do
          base.sty_flow
          expect(base.sty_column_info.keys).to eq(['s0'])
          expect(base.sty_column_info['s0'] - header).to eq([])
        end

        it 'should fetch right result from the given excel' do
          base.sty_flow
          expect(base.sty_raw_data).to eq(
            'MCH' => 999,
            '大類' => 'A',
            '中類' => 'AA',
            '小類' => 'BBB',
            'EC-大分類' => '大',
            'EC-中分類' => '中',
            'EC-小分類' => '小'
          )
        end
      end
    end
  end
end
