# frozen_string_literal: true

class CreateTodoLists < ActiveRecord::Migration[5.2]
  def change
    create_table :todo_lists do |t|
      t.string :name

      t.timestamps
    end
  end
end
