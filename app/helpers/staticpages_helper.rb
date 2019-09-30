module StaticpagesHelper
  # 亂數：https://blog.appsignal.com/2018/07/31/generating-random-numbers-in-ruby.html
  # link_to 使用方式：https://www.rubyguides.com/2019/05/rails-link_to-method/
  # Brohand 教我如何使用 ％（）

  @@song_num = 0
  @@weekly_num = 0 
  # https://stackoverflow.com/questions/5690458/create-module-variables-in-ruby
  
  def song_num
    num = rand(1..23)
    num < 10 ? num = %(0#{num}) : num = %(#{num})
    @@song_num = num
    return @@song_num
  end

  def weekly_num
    num = rand(1..221)
    num < 10 ? num = %(0#{num}) : num = %(#{num})
    @@weekly_num = num
    return @@weekly_num
  end

  def song_link
    return "https://www.rulai.org/song/#{@@song_num}"
  end

  def weekly_link
    return "https://www.rulai.org/weekly/#{@@weekly_num}" 
  end

  def song_title(url)
    # 參考資料；https://nokogiri.org/
    require 'open-uri'
    doc = Nokogiri::HTML(open(url))
    song_name = ""
    doc.xpath('/html/body/div/div[2]/div[2]/article/div[1]/div[1]/h1').each do |link|
      # https://api.rubyonrails.org/classes/ActionView/Helpers/SanitizeHelper.html#method-i-strip_tags
      song_name += strip_tags(link.content.html_safe)
    end
    return song_name
  end

  def weekly_title(url)
    require 'open-uri'
    doc = Nokogiri::HTML(open(url))
    weekly_name = []  
    doc.xpath("//span[@class='weekly_font01']").each do |link|
      weekly_name << strip_tags(link.content.chomp.html_safe)
    end
    weekly_name = weekly_name.join(" ")
    # https://stackoverflow.com/questions/4018689/ruby-combining-an-array-into-one-string
    return weekly_name
  end  
end
