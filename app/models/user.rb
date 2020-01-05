# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  admin                  :boolean          default(FALSE)
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string(255)
#  username               :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :lab_forums
  has_many :comments
  has_many :likes
  has_many :todos

  has_many :visits, class_name: 'Ahoy::Visit'
  has_many :events, class_name: 'Ahoy::Event'

  validates_presence_of :username
  validates_uniqueness_of :email, :username
  validates_format_of :email, :with => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i


  # 賦值(set)
  attr_writer :login

  # Username or Email
  class << self
    def find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { value: login.downcase }]).first
      elsif conditions.has_key?(:username) || conditions.has_key?(:email)
        where(conditions.to_h).first
      end
    end
  end

  # 取值(get)
  def login
    @login || username || email
  end

  def email_required?
    false
  end

  def email_present?
    email.present?
  end

  def build_auth_token(token = nil)

    token = Devise.friendly_token(32) if token.blank?

    Rails.cache.write(
      token,
      {
        user_id: id,
      },
      expires_in: 6.hours
    )

    token
  end
end
