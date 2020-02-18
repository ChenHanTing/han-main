# frozen_string_literal: true

class CreateCategoryMches < ActiveRecord::Migration[5.2]
  def change
    create_table :category_mches do |t|
      t.references :category
      t.references :mch

      t.timestamps
    end
  end
end
