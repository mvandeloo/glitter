
require 'bcrypt'
class User

  include DataMapper::Resource

  property :id, Serial
  property :email, String, :unique => true, :message => "E-Mail is taken"
  property :name, String
  property :username, String, :unique => true, :message => "Username is taken"
  property :password_digest, Text 

  
  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

end