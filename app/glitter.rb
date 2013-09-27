require 'sinatra'
require 'sinatra/base'
require 'data_mapper'
require 'data_mapper'
require './lib/peep'
require './lib/user'
require_relative 'helpers/application'
require_relative 'data_mapper_setup'

enable :sessions
set :session_secret, 'super secret'


get '/' do
  @peeps = Peep.all
  erb :index
end

post '/peeps' do
  status = params["status"]
  Peep.create(:status => status)
  redirect to('/')
end


get '/users/new' do

  erb :"users/new"
end


post '/users' do
  user = User.create(:email => params[:email], 
                     :password => params[:password], :name => params[:name], :username => params[:username])
  session[:user_id] = user.id
  redirect to('/')
end