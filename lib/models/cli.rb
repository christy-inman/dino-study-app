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

    def self.main_menu
        puts ""
        puts ""
        puts "Welcome to the Main Menu, #{@@user.name}"
        puts "What would you like to do today?"
        puts ""
        puts "1. See All Dinosaurs"
        puts "2. See your favorite dinosaurs"
        puts "3. Quit Studying"
        @response = gets.chomp
        if @response == "1"
            puts ""
            puts ""
            all_dino_list
        elsif @response == "2"
            see_favs
        elsif @response == "3"
            puts "Thanks for studying with us today, hope to see you again soon."
        else until @response == "1" || @response == "2" || @response == "3"
            main_menu_response
        end
        end
    end

    def self.all_dino_list
        Dinosaur.all.each_with_index { | dino, index | puts "#{index += 1}. #{dino[:name]}" }
        if !dino_info_card
            main_menu
        else
            puts ""
            puts ""
            puts "Would you like to save this dinosaur as a favorite? y/n"
            @ans = gets.chomp
            if @ans == "y"
                Favorite.create(user_id: @@user.id, dinosaur_id: @@found.id)
                main_menu
            elsif @ans == "n"
                main_menu  
            else 
                until @ans == "y" || @ans == "n"
                    all_dino_helper
                end
            end
        end
    end

    def self.dino_info_card
        puts "Type name of dinosaur you want more information on."
        @response = gets.chomp
        if Dinosaur.find_by(name: @response)
            @@found = Dinosaur.all.find do | dino |
                dino[:name] == @response
            end
            puts "Name: #{@@found.name}" 
            puts "Classification: #{@@found.classification}" 
            puts "Diet: #{@@found.diet}"
            puts "Length: #{@@found.length}" 
            puts "Height: #{@@found.height}" 
            puts "Weight: #{@@found.weight}" 
            puts "Location: #{@@found.location}" 
            puts "Time Period: #{@@found.time_period}" 
            puts "Quick Fact: #{@@found.fact}"
            return true
        else
            return false
        end
    end

    def self.all_dino_helper
        puts "Please enter y or n."
        @ans = gets.chomp
        if @ans == "y"
            Favorite.create(user_id: @@user.id, dinosaur_id: @@found.id)
        elsif @ans == "n"
            main_menu
        end
    end

    def self.see_favs
        if @@user.favorites.count == 0
            puts "Sorry, looks like you don't have any favorites saved."
        else
            var = @@user.favorites.map do |obj|
                obj.dinosaur_id
            end
            counter = 1
            var.each do |int|
                Dinosaur.all.each do |x|
                    if int == x.id
                        puts "#{counter}. #{x.name}"
                    end
                end
                counter += 1
            end
        end
        dino_info_card
        main_menu
    end

    def self.main_menu_response
        puts "Please enter 1, 2, or 3."
        @response = gets.chomp
        if @response == "1"
            Dinosaur.all.each_with_index { | dino, index | puts "#{index += 1}. #{dino[:name]}" }
        elsif @response == "2"
            see_favs
        elsif @response == "3"
            puts "Thanks for studying with us today, hope to see you again soon."
        end
    end
end


    

    
    
    







