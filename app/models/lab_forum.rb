class LabForum < ApplicationRecord
  CATEGORY = ['問答','閒聊','其他'].freeze
  has_many :comments, dependent: :destroy
  belongs_to :user
end
