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
      main_menu
    end

    def self.sign_in
        puts "Enter username:"
        @sign_in = gets.chomp
        if User.find_by(name: @sign_in)
            @@user = User.find_by(name: @sign_in)
          puts "Welcome back, #{@@user.name}!"
        else 
          puts "Looks like you haven't studied with us before."
          sign_up
        end
    end

    def self.sign_up               
        puts "Create username:"
        @sign_up = gets.chomp
        @@user = User.create(name: @sign_up)
        if @@user.valid?
            puts "Welcome to Dino Study Guide, #{@@user.name}!"
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

    def self.try_again
        until @@user.valid? do
           puts "Looks like that username already exists. Try another one."
           sign_up
        end
    end

    # def self.favorite_a_dino
    #     puts "Write the dinosaurs name that you want to add to your study guide"
    #     Dinosaur.all.each_with_index { | dino, index | puts "#{index += 1}. #{dino[:name]}" }
    #     @fav_dino_response = gets.chomp
    #     dino = Dinosaur.all.find { | dino | @fav_dino_response == dino[:name] }
    #     # puts "Please re-enter username:"
    #     # @user_response = gets.chomp 
    #     # user = User.all.find{ | user | @@user == user[:name] }
    #     Favorite.create(user_id: @@user.id, dinosaur_id: dino.id)
    # end

    # def self.list_dinos_data
    #     # @dino_response = Allosaurus
    #     Dinosaur.all.select do | dino |
    #         dino[:name] == Allosaurus
    #         puts "Name: #{dino[:name]}" 
    #         puts "Classification: #{dino[:classification]}" 
    #         puts "Diet: #{dino[:diet]}"
    #         puts "Length: #{dino[:length]}" 
    #         puts "Height: #{dino[:height]}" 
    #         puts "Weight: #{dino[:weight]}" 
    #         puts "Location: #{dino[:location]}" 
    #         puts "Time Period: #{dino[:time_period]}" 
    #         puts "Quick Fact: #{dino[:fact]}"
    #     end
    # end

    def self.main_menu
        puts "Welcome to the Main Menu, #{@@user.name}"
        puts "What would you like to do today?"
        puts "1. See All Dinosaurs"
        puts "2. See your favorite dinosaurs"
        puts "3. Quit Studying"
        @response = gets.chomp
        if @response == "1"
            Dinosaur.all.each_with_index { | dino, index | puts "#{index += 1}. #{dino[:name]}" }
        elsif @response == "2"
            @@user.favorites

            binding.pry
        end

    end


end

    

    
    
    







