class CreateLabForums < ActiveRecord::Migration[5.2]
  def change
    create_table :lab_forums do |t|
      t.string :question, presence: true
      t.text :description, presence: true
      t.boolean :solved, default: false
      t.string :category, presence: true

      t.integer :user_id, foreign_key: true
      t.integer :click, default: 0
      # t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
