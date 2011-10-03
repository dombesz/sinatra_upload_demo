require 'rubygems'
require 'sinatra'
require './models'
require './helpers'


get '/' do
  @uploads = Upload.all(:order => [ :id.desc ])
  @uuid = UUID.new.generate
  @upload = Upload.new
  erb :index
end

post '/files' do
  content_type :js if request.xhr?
  @uuid = UUID.new.generate
  @upload = Upload.first_or_new({:uuid=>params[:uuid]})
  @upload.attributes = params[:upload]
  @upload.save
  erb :file,  :layout => request.xhr? ? false : :file_layout
end

get '/progress' do
  content_type :json
  cache_control :private, :must_revalidate, :max_age => 0
  response = {:result=>-1, :new_uuid=>UUID.new.generate}
  response.merge!({:result=> request.env['rack.progress'][params[:uuid]]}) if params[:uuid] && request.env['rack.progress'][params[:uuid]]
  response.to_json
end
