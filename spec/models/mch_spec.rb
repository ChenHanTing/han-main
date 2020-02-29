# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mch, type: :model do
  let(:file_name) { './spec/support/files/import_sheets/ex02.xlsx' }

  describe '.import_sheets' do
    context 'check records' do
      it 'creates Mch' do
        Mch.import_sheets(file_name)

        mch01 = Mch.find_by(
          c1: 's0',
          c2: '大類',
          c3: '中類',
          c4: '小類',
          code: '999AAABBB'
        )

        mch02 = Mch.find_by(
          c1: 's0',
          c2: '大類',
          c3: '中類',
          c4: nil,
          code: '999AAA'
        )

        mch03 = Mch.find_by(
          c1: 's0',
          c2: '大類',
          c3: nil,
          c4: nil,
          code: '999A'
        )

        mch04 = Mch.find_by(
          c1: 's0',
          c2: nil,
          c3: nil,
          c4: nil,
          code: '999'
        )

        expect(mch01.nil?).to eq(false)
        expect(mch02.nil?).to eq(false)
        expect(mch03.nil?).to eq(false)
        expect(mch04.nil?).to eq(false)
      end
    end
  end
end
