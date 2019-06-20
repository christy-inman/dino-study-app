require 'pry'

class CLI
    
    def self.welcome
        puts "Welcome to Dino Study Guide, let's get started!"
        puts ""
        puts "1. Sign-in" 
        puts "2. Sign-up"
        @response = gets.chomp
        case @response 
        when "1"
            sign_in
        when "2"
            sign_up
        else
            until @response == "1" || @response == "2"
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
          puts "Welcome back, #{@@user.name.capitalize}!"
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
            puts "Welcome to Dino Study Guide, #{@@user.name.capitalize}!"
        else
          try_again
        end
    end

    def self.response
        puts "Please enter 1 or 2: "
        @response = gets.chomp
        case @response 
        when "1"
            sign_in
        when "2"
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
        puts "Main Menu:"
        puts "What would you like to do today?"
        puts ""
        puts "1. See all dinosaurs."
        puts "2. See your favorite dinosaurs."
        puts "3. Quit studying."
        @response = gets.chomp
        case @response 
        when "1"
            puts ""
            puts ""
            all_dino_list
        when "2"
            see_favs
        when "3"
            puts "Thanks for studying with us today, hope to see you again soon."
        else 
            until @response == "1" || @response == "2" || @response == "3"
            main_menu_response
            end
        end
    end

    def self.all_dino_list
        Dinosaur.all.each_with_index { | dino, index | puts "#{index += 1}. #{dino[:name]}" }
        puts "Type name of dinosaur you want more information on."
        puts "Or press enter to return to the Main Menu."
        if !dino_info_card
            main_menu
        else
            puts ""
            puts ""
            puts "Would you like to save this dinosaur as a favorite? y/n"
            @ans = gets.chomp
            case @ans
            when "y"
                new_favorite
            when "n"

            else 
                until @ans == "y" || @ans == "n"
                    all_dino_helper
                end
            end
          main_menu  
        end
    end

    def self.dino_info_card
        @response = gets.chomp
        if Dinosaur.find_by(name: @response)
            @@found = Dinosaur.all.find { | dino | dino[:name] == @response }
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

    # def self.all_dino_helper
    #     puts "Please enter y or n:"
    #     @ans = gets.chomp
    #     case @ans  
    #     when "y"
    #         new_favorite
    #     when "n"
    #     end
    # end

    def self.see_favs
        if @@user.favorites.count == 0
            puts "Sorry, looks like you don't have any favorites saved."
        else
            existing_favs_list
        puts "Type name of dinosaur you want more information on."
        puts "Or press enter to return to Main Menu."
        dino_info_card
        end
        main_menu
    end

    def self.main_menu_response
        puts "Please enter 1, 2, or 3."
        @response = gets.chomp
        case @response 
        when "1"
            all_dino_list
        when "2"
            see_favs
        when "3"
            puts "Thanks for studying with us today, hope to see you again soon."
        end
    end

    def self.existing_favs_list
        counter = 1
        @@user.favorites.each do |user_obj| 
            puts "#{counter}. #{user_obj.dinosaur.name}" 
            counter += 1 
        end
    end

    def self.new_favorite
        Favorite.create(user_id: @@user.id, dinosaur_id: @@found.id)
    end

end


    

    
    
    







