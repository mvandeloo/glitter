
require 'bcrypt'
class User
	attr_reader :password
	attr_accessor :password_confirmation

	
  include DataMapper::Resource

  property :id, Serial
  property :email, String, :unique => true, :message => "This email is already taken"
  property :name, String
  property :username, String, :unique => true, :message => "Username is taken"
  property :password_digest, Text 
  validates_confirmation_of :password


	def password=(password)
	    @password = password
	    self.password_digest = BCrypt::Password.create(password)
	end

	def self.authenticate(email, password)

	  user = first(:email => email)
	  # user.password_token = Array.new(64) {(65 + rand(58)).chr}.join
   #  	user.password_token_timestamp = Time.now
    	# user.save
    	
	  if user && BCrypt::Password.new(user.password_digest) == password
	    user
	  else
	    nil
	  end



	end


end