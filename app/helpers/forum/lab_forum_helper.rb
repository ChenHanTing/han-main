module Forum::LabForumHelper
  def solved_monitor(bool)
    if bool
      fa_icon "check 2x", right: true
    else
      fa_icon "times 2x", right: true
    end
  end

  def del_p_mark(str)
    str.gsub(/<p>.*<\/p>/, '').html_safe 
    # 網站：https://www.rubyguides.com/2019/07/ruby-gsub-method/
    # 網站：https://stackoverflow.com/questions/52853995/replacing-html-tag-and-its-content-using-ruby-gsub
  end
end
