class StaticpagesController < ApplicationController
  def show 
    if valid_page?
      # render template: "pages/#{params[:single_page]}"
      render params[:single_page]
    else 
      render file: "public/404.html", status: :not_found 
    end 
  end

  private
  
  def valid_page?
    File.exist?(Pathname.new(Rails.root + "app/views/staticpages/#{params[:single_page]}.html.erb")) 
  end
end
