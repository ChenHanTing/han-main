# frozen_string_literal: true

require 'rails_helper'

module ImportSheets
  RSpec.describe Base do
    let(:wrong_file) { './spec/support/files/import_sheets/ex01.txt' }
    let(:file_name) { './spec/support/files/import_sheets/ex01.xlsx' }
    let(:base) { ImportSheets::Base.new(nil, file_name) }
    let(:file) { File.open(file_name) }

    describe '#sty_flow' do
      context 'basic sheet import testing' do
        it 'should raise error from given excel' do
          expect { base.open_spreadsheet(wrong_file) }.to raise_error
        end

        it 'should not raise error from the given excel' do
          expect { base.open_spreadsheet(file_name) }.to_not raise_error
        end

        it 'should fetch file name from the given excel' do
          base.sty_info = base.init_deep_hash
          expect(base.strategy_sheets.first).to eq(file_name)
        end

        it 'should fetch all sheets name from the given excel' do
          base.sty_info = base.init_deep_hash
          expect(base.strategy_sheets.second).to eq(%w[s0 s1])
        end

        it 'should fetch right sheet header from the given excel' do
          base.sty_info = base.init_deep_hash
          base.strategy_sheets
          base.strategy_columns
          expect(base.sty_column_info).to eq('s0' => %w[h1 h2 h3])
        end

        it 'should successfully run strategy flow from the given excel' do
          base.sty_flow
          expect(base.sty_column_info).to eq('s0' => %w[h1 h2 h3])
        end

        it 'should fetch right result from the given excel' do
          base.sty_flow
          expect(base.sty_raw_data).to eq('h1' => 7, 'h2' => 8, 'h3' => 9)
        end
      end
    end
  end
end
