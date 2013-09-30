require 'sinatra'
require 'sinatra/base'
require 'data_mapper'
require 'rack-flash'
use Rack::Flash
require './lib/user'
require './lib/peep'
require_relative 'helpers/application'
require_relative 'data_mapper_setup'

enable :sessions
set :session_secret, 'super secret'


get '/' do
  @peeps = Peep.all
  erb :index
end


get '/users/new' do
  @user = User.new
  erb :"users/new"
end


get '/sessions/new' do
  erb :"sessions/new"
end

post '/peeps' do
  status = params["status"]
  username = params["username"]
  name = params["name"]
  @peep = Peep.create(:status => status, :username => username, :name => name)
  redirect to('/')
end

post '/users' do
  @user = User.new(:email => params[:email], 
              :password => params[:password], 
              :password_confirmation => params[:password_confirmation])
  if @user.save
    session[:user_id] = @user.id
    redirect to('/')
  else
    flash.now[:errors] = @user.errors.full_messages
    erb :"users/new"
  end
end



post '/sessions' do
  email, password = params[:email], params[:password]
  user = User.authenticate(email, password)
  if user
    session[:user_id] = user.id
    redirect to('/')
  else
    flash[:errors] = ["The email or password are incorrect"]
    erb :"sessions/new"
  end
end

delete '/sessions' do
  flash[:notice] = "Good bye!"
  session[:user_id] = nil
  redirect to('/')
end
