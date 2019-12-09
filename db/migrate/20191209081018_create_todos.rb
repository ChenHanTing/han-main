class CreateTodos < ActiveRecord::Migration[5.2]
  def change
    create_table :todos do |t|
      t.text :content
      t.datetime :complete_time, default: nil
      t.boolean :status, default: false
      t.integer :priority, default: 0

      t.timestamps
    end
  end
end
