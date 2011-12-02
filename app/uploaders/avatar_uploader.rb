# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    "/assets/" + [version_name, "avatar.jpg"].compact.join('_')
  end

  process :resize_to_fill => [32,32]

  version :thumb do
    process :resize_to_fill => [24,24]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

end
