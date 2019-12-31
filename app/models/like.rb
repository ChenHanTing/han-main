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

class Like < ApplicationRecord
  belongs_to :expressable, polymorphic: true
  belongs_to :user

  after_save :multiple_click
  after_save :like_counter

  def like_counter
    if expressable.respond_to?('like') && self.expression.positive?
      expressable.increment!('like'.to_sym)
    end
  end

  def multiple_click
    click_data = expressable.likes.where(user_id: user.id)
    if click_data.count > 1
      first = click_data.first
      last = click_data.last
      click_data.delete_all if last.expression.eql? first.expression

      first.delete
    end
  end
end
