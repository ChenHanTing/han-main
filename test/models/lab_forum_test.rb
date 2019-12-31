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

require 'test_helper'

class LabForumTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
