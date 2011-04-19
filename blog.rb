require 'sinatra'
require 'haml'
require 'sass'

enable :sessions

get '/' do
  session["logged_in"] ||= nil
  if session["logged_in"]
    haml :index, :locals => {:user => @@user}
  else
    redirect '/login'
  end
end

get '/login' do
  haml :login
end

post '/login' do
  @@user = params[:username]
  @passwd = params[:password]

  if 'admin' == @@user and 'hello' == @passwd
    session["logged_in"] = true
    redirect '/'
  else
    "Wrong"
  end
    
end

get '/logout' do
  session["logged_in"] = nil
  redirect '/'
end

get '/style.css' do
  sass :style
end
