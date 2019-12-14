class CreateTodos < ActiveRecord::Migration[5.2]
  def change
    create_table :todos do |t|
      t.text :content
      t.integer :priority, default: 0
      t.boolean :status, default: false
      t.references :user, foreign_key: true
      t.datetime :complete_time, default: nil

      t.timestamps
    end
  end
end
