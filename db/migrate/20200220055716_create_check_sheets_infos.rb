# frozen_string_literal: true

class CreateCheckSheetsInfos < ActiveRecord::Migration[5.2]
  def change
    create_table :check_sheets_infos do |t|
      t.string :code
      t.string :path
      t.string :mch_path
      t.json :detail

      t.timestamps
    end
  end
end
