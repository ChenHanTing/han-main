class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :user

  # 非多型的寫法
  # belongs_to :lab_forum

  has_one_attached :cover
  has_many :likes
end
