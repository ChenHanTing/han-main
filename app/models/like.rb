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
