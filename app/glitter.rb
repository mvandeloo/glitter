require 'sinatra'
require 'sinatra/base'
require 'data_mapper'
require './lib/peep'
require 'rack-flash'
use Rack::Flash
require './lib/user'
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
  Peep.create(:status => status)
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


