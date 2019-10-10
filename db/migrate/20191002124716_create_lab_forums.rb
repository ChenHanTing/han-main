class CreateLabForums < ActiveRecord::Migration[5.2]
  def change
    create_table :lab_forums do |t|
      t.string :question, presence: true
      t.string :description, presence: true
      t.boolean :is_solved, default: false
      t.string :category, presence: true
      
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
