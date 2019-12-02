class Comment < ApplicationRecord
  belongs_to :lab_forum
  belongs_to :user

  has_one_attached :cover

  validate :image_type

  def image_type
    if cover.attached? == false
      errors.add(:cover, 'required')
    elsif !cover.content_type.in? ['image/jpeg', 'image/png']
      errors.add(:cover, 'not supported')
    end
  end
end
