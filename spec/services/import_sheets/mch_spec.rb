# frozen_string_literal: true

require 'rails_helper'

module ImportSheets
  RSpec.describe Mch do
    let(:file_name) { './spec/support/files/import_sheets/ex02.xlsx' }
    let(:base) { ImportSheets::Mch.new(::Mch, file_name) }
    let(:file) { File.open(file_name) }
    let(:header) { %w[MCH 大類 大類名稱 中類 中類名稱 小類 小類名稱] }

    describe '#sty_flow' do
      context 'mch sheet import testing' do
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
            '大類名稱' => '大類',
            '中類' => 'AA',
            '中類名稱' => '中類',
            '小類' => 'BBB',
            '小類名稱' => '小類'
          )
        end
      end
    end
  end
end
