module Recount
  # 數讚的數量 / 噓的數量
  def recount_expression
    if respond_to? 'like'
      update!( click: likes.where("expression = 'like'").count )
    elsif respond_to? 'dislike'
      update!( dislike: likes.where("expression = 'dislike'").count )
    end
  end
end
