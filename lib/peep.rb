
class Peep


  include DataMapper::Resource

 
  property :id,     Serial # Serial means that it will be auto-incremented for every record
  property :status,  String
  property :username,  Serial
  property :name, Serial



	# def username=(username)
	#     @username = username
	# end

	# def name=(name)
	#     @name = name
	# end

end