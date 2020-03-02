# frozen_string_literal: true

# == Schema Information
#
# Table name: todo_lists
#
#  id         :bigint           not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class TodoList < ApplicationRecord
  has_many :tasks, dependent: :destroy

  accepts_nested_attributes_for :tasks, allow_destroy: true, reject_if: proc { |att| att['name'].blank? }
  # accepts_nested_attributes_for :tasks, allow_destroy: true, reject_if: :all_blank

  validates :name, presence: true
end
