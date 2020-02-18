class AddAuthenticationTokenToIdeas < ActiveRecord::Migration[5.2]
  def change
    add_column :ideas, :authentication_token, :string
  end
end
