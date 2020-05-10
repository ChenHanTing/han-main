# frozen_string_literal: true

# == Schema Information
#
# Table name: companies
#
#  id         :bigint           not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Company < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :employees, dependent: :destroy

  def to_s
    name
  end
end
