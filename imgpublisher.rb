require 'sinatra'
require 'haml'
require 'pry'

get '/' do
  file = File.new("img_url.txt", "r")
  img_url = file.read
  haml :index, :locals => {:img_src => img_url}
end

get '/publish_img' do
  haml :publish_img
end

get '/push_img' do
  file = File.new('img_url.txt', 'w')
  file.write(params[:post][:img_url])
  file.close
  redirect '/publish_img'
end
