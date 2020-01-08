module Helper::Site
  def site_admin?
    request.subdomain == 'admin'
  end

  def site_api?
    request.subdomain == 'api'
  end

  # def req_json?
  #   request.format.json?
  # end

  # def req_html?
  #   request.format.html?
  # end
end
