class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :content
      t.references :commentable, polymorphic: true
      t.references :user, foreign_key: true
      # t.integer :lab_forum_id, foreign_key: true
      # t.references :lab_forum, foreign_key: true
      # t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
