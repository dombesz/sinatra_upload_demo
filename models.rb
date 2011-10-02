require 'carrierwave/datamapper'
require 'data_mapper'


#carrierwave configuration

CarrierWave.configure do |config|
  config.root = Dir.pwd
  config.cache_dir = 'tmp'

   config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => 'SECRET_KEY',
    :aws_secret_access_key  => 'SECRET_KEY2'
  }
  config.fog_directory  = 'sinatra-upload'
end


DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/development.db")

class FileUploader < CarrierWave::Uploader::Base
  storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
end

class Upload
  include DataMapper::Resource
  
  property :id, Serial
  property :uuid, String, :key => true
  property :comment, Text
  mount_uploader :file, FileUploader
end

DataMapper.auto_upgrade!