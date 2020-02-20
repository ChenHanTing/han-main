# == Schema Information
#
# Table name: check_sheets_infos
#
#  id         :bigint           not null, primary key
#  code       :string(255)
#  detail     :json
#  mch_path   :string(255)
#  path       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class CheckSheetsInfoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
