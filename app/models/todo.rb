# == Schema Information
#
# Table name: todos
#
#  id            :bigint           not null, primary key
#  complete_time :datetime
#  content       :text(65535)
#  priority      :integer          default(0)
#  status        :boolean          default(FALSE)
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
  enum priorities: {low: 0, medium: 1, high: 2, urgent: 3}

  validates :content, presence: true
end
