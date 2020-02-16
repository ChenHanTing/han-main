# frozen_string_literal: true

# == Schema Information
#
# Table name: mches
#
#  id         :bigint           not null, primary key
#  c1         :string(255)
#  c2         :string(255)
#  c3         :string(255)
#  c4         :string(255)
#  cs         :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Mch < ApplicationRecord
  include ImportSheets
  include Import::Sheets::Strategy

  # SHEET_COLUMN: 存放工作表的欄位名稱
  # HEADER: Excel表的標題行
  SHEET_COLUMN = 'c1'
  CODE_COLUMN = 'cs'
  HEADER = {
    '大類名稱': 'c2',
    '中類名稱': 'c3',
    '小類名稱': 'c4',
    '大類': 'cc2',
    '中類': 'cc3',
    '小類': 'cc4'
  }.freeze

  # Mch.run_script('smsheets.xlsx')
  def self.run_script(file_name)
    file = File.open(file_name)
    import_sheets(file)
  end

  # Example
  # Mch.inspect_sheetheader('smsheets.xlsx')
  def self.inspect_sheetheader(file_name)
    file = File.open(file_name)
    spreadsheet = open_spreadsheet(file)
    spreadsheet.each_with_pagename do |_name, sheet|
      puts("Header: #{sheet.row(1)}")
    end
  end

  # Mch.new.sty_flow('example.xlsx')
  def sty_flow(file_name)
    sheet_info = strategy_sheets(file_name)
    column_info = strategy_columns(self, sheet_info)
    data = strategy_array(sheet_info, column_info)
  end
end
