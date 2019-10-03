class LabForum < ApplicationRecord
  has_many :comments, dependent: :destroy
end
