# == Schema Information
#
# Table name: category_mches
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint
#  mch_id      :bigint
#
# Indexes
#
#  index_category_mches_on_category_id  (category_id)
#  index_category_mches_on_mch_id       (mch_id)
#

require 'test_helper'

class CategoryMchTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
