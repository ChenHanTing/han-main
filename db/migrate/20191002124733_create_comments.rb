class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :comment
      # t.integer :lab_forum_id
      t.references :lab_forum, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
