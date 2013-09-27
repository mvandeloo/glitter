env = ENV["RACK_ENV"] || "development"


DataMapper.setup(:default, "postgres://localhost/glitter_#{env}")

DataMapper.finalize

DataMapper.auto_upgrade!
