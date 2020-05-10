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
require 'test_helper'

class EmployeeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
