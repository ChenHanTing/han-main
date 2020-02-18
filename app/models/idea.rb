# frozen_string_literal: true

# == Schema Information
#
# Table name: ideas
#
#  id                   :bigint           not null, primary key
#  authentication_token :string(255)
#  body                 :text(65535)
#  title                :string(255)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class Idea < ApplicationRecord
  before_create :generate_unique_secure_token

  private

  def generate_unique_secure_token
    # return if self.authentication_token.present?
    loop do
      token = SecureRandom.base58(24)
      self.authentication_token = token
      break token unless self.class.find_by(authentication_token: token)
    end
  end
end
