require 'pry'

class CLI
    
    def self.welcome
        puts "Welcome to Dino Study Guide, let's get started!"
        puts "1. sign-in" 
        puts "2. sign-up"
        @response = gets.chomp
        if @response == "1"
            sign_in
        elsif @response == "2"
            sign_up
        else until @response == "1" || @response == "2"
            response
        end
      end
    end

    def self.sign_in
        puts "Enter username:"
        @sign_in = gets.chomp
        if User.find_by(name: @sign_in)
          puts "Welcome back, #{@sign_in}!"
        else 
          puts "Looks like you haven't studied with us before."
          sign_up
        end
    end

    def self.sign_up               
        puts "Create username:"
        @sign_up = gets.chomp
        @new_user = User.create(name: @sign_up)
        if @new_user.valid?
            puts "Welcome to Dino Study Guide, #{@new_user.name}!"
        else
          try_again
        end
    end

    def self.response
        puts "Please enter 1 or 2: "
        @response = gets.chomp
        if @response == "1"
            sign_in
        elsif @response == "2"
            sign_up
        end
    end

    def self.favorite_a_dino
        puts "Write the dinosaurs name that you want to add to your study guide"
        Dinosaur.all.each_with_index { | dino, index | puts "#{index += 1}. - #{dino[:name]}" }
        @fav_dino_response = gets.chomp
        dino = Dinosaur.all.find { | dino | @fav_dino_response == dino[:name] }
        puts "Please re-enter username: "
        @user_response = gets.chomp 
        user = User.all.find{ | user | @user_response == user[:name] }
        Favorite.create(user_id: user.id, dinosaur_id: dino.id)
    end

    def self.list_dinos_data
        Dinosaur.all.each do | dino |
            puts "Name: #{dino[:name]}" 
            puts "Classification: #{dino[:classification]}" 
            puts "Diet: #{dino[:diet]}"
            puts "Length: #{dino[:length]}" 
            puts "Height: #{dino[:height]}" 
            puts "Weight: #{dino[:weight]}" 
            puts "Location: #{dino[:location]}" 
            puts "Time Period: #{dino[:time_period]}" 
            puts "Quick Fact: #{dino[:fact]}"
        end
    end


end

    

    
    
    







