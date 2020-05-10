# == Schema Information
#
# Table name: members
#
#  id         :bigint           not null, primary key
#  name       :string(255)
#  properties :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'test_helper'

class MemberTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
