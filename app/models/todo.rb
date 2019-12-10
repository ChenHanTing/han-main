class Todo < ApplicationRecord
  enum priorities: {low: 0, medium: 1, high: 2, urgent: 3}

  validates :content, presence: true
end
