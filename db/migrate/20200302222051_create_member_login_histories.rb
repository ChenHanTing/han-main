class CreateMemberLoginHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :member_login_histories do |t|
      t.string :login_member
      t.datetime :login_at

      t.timestamps
    end
  end
end
