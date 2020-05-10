# frozen_string_literal: true

# == Schema Information
#
# Table name: employees
#
#  id           :bigint           not null, primary key
#  first_name   :string(255)
#  last_name    :string(255)
#  phone_number :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  company_id   :bigint
#
# Indexes
#
#  index_employees_on_company_id  (company_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#
class Employee < ApplicationRecord
  belongs_to :company, touch: true

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :company, presence: true

  def to_s
    "#{first_name} #{last_name}"
  end
end
