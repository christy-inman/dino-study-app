require 'sinatra/activerecord'
require 'pry'
require 'sqlite3'
require 'require_all'
require 'colorize'
require_all 'lib'
require 'colorize' 
require 'colorized_string'

ActiveRecord::Base.establish_connection(
    adapter: "sqlite3",
    database: "db/dinosaur_facts.db"
)

ActiveRecord::Base.logger = nil




# binding.pry


 CLI.welcome
 

