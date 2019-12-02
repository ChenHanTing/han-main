# frozen_string_literal: true

class Ckeditor::Picture < Ckeditor::Asset
  validate :image_type
  # for validation, see https://github.com/igorkasyanchuk/active_storage_validations

  def url_content
    rails_representation_url(storage_data.variant(resize: '800>').processed, only_path: true)
  end

  def url_thumb
    rails_representation_url(storage_data.variant(resize: '118x100').processed, only_path: true)
  end

  def image_type
    if storage_data.attached? == false
      errors.add(:storage_data, 'required')
    elsif !storage_data.content_type.in? ['image/jpeg', 'image/png']
      errors.add(:storage_data, 'not supported')
    end
  end
end
