class Site < ApplicationRecord
  def locale
    (locales || []).split(/,/).first
  end
end