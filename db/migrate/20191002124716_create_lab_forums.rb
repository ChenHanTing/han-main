class CreateLabForums < ActiveRecord::Migration[5.2]
  def change
    create_table :lab_forums do |t|
      t.string :question
      t.string :description
      t.boolean :is_solved
      t.string :category

      t.timestamps
    end
  end
end
