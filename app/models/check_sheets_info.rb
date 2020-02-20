# frozen_string_literal: true

# == Schema Information
#
# Table name: check_sheets_infos
#
#  id         :bigint           not null, primary key
#  code       :string(255)
#  detail     :json
#  mch_path   :string(255)
#  path       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CheckSheetsInfo < ApplicationRecord
  # Mch.import_sheets('example.xlsx')
  def self.import_sheets(file_name)
    delete_all
    ImportSheets::CheckSheetsInfo.new(self, file_name).sty_flow
  end
end
