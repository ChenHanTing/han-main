class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :name
      t.text :comment
      t.integer :lab_forum_id
      
      t.timestamps
    end
  end
end
