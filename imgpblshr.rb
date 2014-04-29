require 'sinatra'
require 'sinatra-websocket'
require 'haml'
require 'redis'

set :sockets, []

set :environment, :production

set :redis, Redis.new(url: ENV['REDISTOGO_URL'])

get '/' do
  redirect '/this-is-the-scope-to-share-image-into/'
end

get '/:scope/' do
  if !request.websocket?
    image_url = settings.redis.get(params[:scope])
    haml :index, locals: {img_src: image_url}
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

get '/:scope/push' do
  haml :push
end

post '/:scope/push' do
  image_url = settings.redis.set(params[:scope], params[:url])

  settings.sockets.each do |ws|
    ws.send(params[:url])
  end
  
  redirect "#{params[:scope]}/push"
end
