# frozen_string_literal: true

module Admin::LabForumsHelper
  # 改變狀態
  def solved_monitor(bool)
    if bool
      fa_icon 'check 2x', right: true
    else
      fa_icon 'times 2x', right: true
    end
  end

  # 把<p>...</p>元素去除
  def del_p_mark(str)
    str.gsub(%r{<p>.*</p>}, '').html_safe
    # 網站：https://www.rubyguides.com/2019/07/ruby-gsub-method/
    # 網站：https://stackoverflow.com/questions/52853995/replacing-html-tag-and-its-content-using-ruby-gsub
  end

  # 判斷是否已經按讚
  def clicked(lab_forum_id)
    LabForum.find_by(id: lab_forum_id).likes.present?
  end
end
