require 'sinatra'
require 'sinatra-websocket'
require 'haml'

set :sockets, []

set :environment, :production

get '/' do
  if !request.websocket?
    file = File.new("img_url.txt", "r")
    img_url = file.read
    haml :index, :locals => {:img_src => img_url}
  else
    request.websocket do |ws|

      ws.onopen do
        settings.sockets << ws
      end
      
      ws.onclose do
        settings.sockets.delete(ws)
      end

    end
  end
end

get '/publish_img' do
  haml :publish_img
end

get '/push_img' do
  file = File.new('img_url.txt', 'w')
  file.write(params[:post][:img_url])
  file.close

  settings.sockets.each do |ws|
    ws.send(params[:post][:img_url])
  end
  
  redirect '/publish_img'
end
