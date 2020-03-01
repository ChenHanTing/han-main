# == Schema Information
#
# Table name: likes
#
#  id               :bigint           not null, primary key
#  expressable_type :string(255)
#  expression       :integer          default("0")
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

  after_save :addition_counter
  after_destroy :substraction_counter

  def addition_counter
    expressable.increment!('click'.to_sym) if expressable.respond_to?('click')
  end

  def substraction_counter
    expressable.decrement!('click'.to_sym) if expressable.respond_to?('click')
  end

  # 收回讚（建議從controller做）
  # after_save :multiple_click
  #
  # def multiple_click
  #   click_data = expressable.likes.where(user_id: user.id)
  #   if click_data.count > 1
  #     first = click_data.first
  #     last = click_data.last
  #     click_data.delete_all if last.expression.eql? first.expression

  #     first.delete
  #   end
  # end

  # def addition_counter
  #   counter_adj(:increment!)
  # end

  # def substraction_counter
  #   counter_adj(:decrement!)
  # end

  # def counter_adj(method_adj)
  #   {click: :like, dislike: :dislike}.each do |k, v|
  #     expressable.send(method_adj, k) if check_respond_to?(k, v)
  #   end
  # end

  # def check_respond_to?(column_name, exp)
  #   expressable.respond_to?(column_name) && expression == exp.to_s
  # end
end
