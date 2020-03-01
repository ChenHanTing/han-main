# == Schema Information
#
# Table name: todos
#
#  id            :bigint           not null, primary key
#  complete_time :datetime
#  content       :text(65535)
#  priority      :integer          default("0")
#  status        :boolean          default("0")
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :bigint
#
# Indexes
#
#  index_todos_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class Todo < ApplicationRecord
  enum priority: {low: 0, medium: 1, high: 2, urgent: 3}

  validates_presence_of :priority, :content

  belongs_to :user
end
