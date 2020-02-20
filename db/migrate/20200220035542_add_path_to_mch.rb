# frozen_string_literal: true

class AddPathToMch < ActiveRecord::Migration[5.2]
  def change
    add_column :mches, :path, :string
  end
end
