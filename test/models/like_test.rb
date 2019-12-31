# == Schema Information
#
# Table name: likes
#
#  id               :bigint           not null, primary key
#  expressable_type :string(255)
#  expression       :integer          default(0)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  expressable_id   :bigint
#  user_id          :bigint
#
# Indexes
#
#  index_likes_on_expressable_type_and_expressable_id  (expressable_type,expressable_id)
#  index_likes_on_user_id                              (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

require 'test_helper'

class LikeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
