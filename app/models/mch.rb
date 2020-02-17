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

  # HEADER: Excel表的標題行
  HEADER = %w[MCH 大類名稱 中類名稱 小類名稱 大類 中類 小類].freeze

  # # Mch.run_script('smsheets.xlsx')
  # def self.run_script(file_name)
  #   file = File.open(file_name)
  #   import_sheets(file)
  # end

  # # Example
  # # Mch.inspect_sheetheader('smsheets.xlsx')
  # def self.inspect_sheetheader(file_name)
  #   file = File.open(file_name)
  #   spreadsheet = open_spreadsheet(file)
  #   spreadsheet.each_with_pagename do |_name, sheet|
  #     puts("Header: #{sheet.row(1)}")
  #   end
  # end

  # Mch.import_sheets('example.xlsx')
  def self.import_sheets(file_name)
    handler = Importsheets.new(self, file_name).sty_flow
    handler.each { |item| find_or_create_by!(item) }
  end
end
