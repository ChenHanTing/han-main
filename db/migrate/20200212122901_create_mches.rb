# frozen_string_literal: true

class CreateMches < ActiveRecord::Migration[5.2]
  def change
    create_table :mches do |t|
      t.string :c1
      t.string :c2
      t.string :c3
      t.string :c4
      t.string :code

      t.timestamps
    end
  end
end
