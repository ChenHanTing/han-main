# frozen_string_literal: true

# == Schema Information
#
# Table name: ckeditor_assets
#
#  id                :bigint           not null, primary key
#  data_content_type :string(255)
#  data_file_name    :string(255)      not null
#  data_file_size    :integer
#  data_fingerprint  :string(255)
#  type              :string(30)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_ckeditor_assets_on_type  (type)
#


class Ckeditor::Picture < Ckeditor::Asset
  after_create :polymorphic_type
  before_save :validate_upload_image
  after_create :image_name

  WIDTH = 800
  HEIGHT = 800
  FILE_SIZE_LIMIT = 10000000

  def url_content
    rails_representation_url(storage_data.variant(resize: '800>').processed, only_path: true)
  end

  def url_thumb
    rails_representation_url(storage_data.variant(resize: '118x100').processed, only_path: true)
  end

  def validate_upload_image
    # if storage_data.attached?
    #   storage_data.purge
    #   errors.add(:storage_data, 'is required')
    #   throw(:abort)
    if storage_data.blob.byte_size > FILE_SIZE_LIMIT
      halt_callback('is too big')
    elsif !storage_data.blob.content_type.starts_with?('image/')
      halt_callback('is in wrong format')
    else
      dimension = ActiveStorage::Analyzer::ImageAnalyzer.new(blob).metadata
      width = dimension.dig(:width)
      height = dimension.dig(:height)
      halt_callback('is too big in dimension') if width > WIDTH || height > HEIGHT
    end
  end

  def image_name
    name = "Image#{rand(100..999)}_#{Time.current.strftime("%Y%m%d%H%M%S")}"
    # 再試試看
    # data.original_filename = "asdf.jpeg"
    # storage_data.blob.filename = new_name
    # storage_data.blob.filename.instance_variable_set( :@filename, new_name )
    storage_data.blob.update(filename: "#{name}.#{storage_data.filename.extension}")
  end

  def polymorphic_type
  end

  private

  def halt_callback(error_message)
    storage_data.purge
    errors.add(:storage_data, error_message)
    throw(:abort)
  end
end
