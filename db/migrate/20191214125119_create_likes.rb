class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.integer :expression, default: 0
      t.references :expressable, polymorphic: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
