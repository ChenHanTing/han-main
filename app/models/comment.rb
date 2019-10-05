class Comment < ApplicationRecord
  belongs_to :lab_forum
  belongs_to :user
end
