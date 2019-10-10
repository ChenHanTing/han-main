class LabForum < ApplicationRecord
  CATEGORY = ['qa','chat','others'].freeze
  has_many :comments, dependent: :destroy
  belongs_to :user
end
