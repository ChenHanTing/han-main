# frozen_string_literal: true

# == Schema Information
#
# Table name: tasks
#
#  id           :bigint           not null, primary key
#  completed    :boolean
#  due          :date
#  name         :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  todo_list_id :bigint
#
# Indexes
#
#  index_tasks_on_todo_list_id  (todo_list_id)
#
# Foreign Keys
#
#  fk_rails_...  (todo_list_id => todo_lists.id)
#
class Task < ApplicationRecord
  belongs_to :todo_list, optional: true

  validates :name, presence: true
  validates :due, presence: true
end
