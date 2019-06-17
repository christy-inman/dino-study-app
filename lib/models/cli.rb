require 'pry'

class CLI
    
    def self.main_menu
        puts "Welcome to Dino Facts"
        puts "Please enter your first name: "
        @response = gets.chomp
    
    end
end