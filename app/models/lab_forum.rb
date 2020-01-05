# == Schema Information
#
# Table name: lab_forums
#
#  id          :bigint           not null, primary key
#  category    :string(255)
#  click       :integer          default(0)
#  description :text(65535)
#  question    :string(255)
#  solved      :boolean          default(FALSE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#

class LabForum < ApplicationRecord
  include Recount

  CATEGORY = ['qa','chat','others'].freeze

  # has_many :comments, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :expressable, dependent: :destroy

  validates_presence_of :question, :description, :category

  belongs_to :user
end
