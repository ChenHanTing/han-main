class Todo < ApplicationRecord
  enum priority: [:low, :medium, :high, :urgent]
end
