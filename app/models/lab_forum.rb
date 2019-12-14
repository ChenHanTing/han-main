class LabForum < ApplicationRecord
  CATEGORY = ['qa','chat','others'].freeze

  # has_many :comments, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :expressable, dependent: :destroy

  belongs_to :user
end
