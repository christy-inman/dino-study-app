require 'pry'
require 'colorize'

class CLI
    
    def self.welcome
        puts ""
        puts "Welcome to Dino Study Guide, let's get started!".colorize(:black).on_magenta.blink
        puts ""
        puts "1. Sign-in".magenta 
        puts "2. Sign-up".magenta 
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
        puts ""
        puts "Enter username:".colorize(:black).on_magenta
        @sign_in = gets.chomp
        if User.find_by(name: @sign_in)
            @@user = User.find_by(name: @sign_in)
            puts ""  
            puts "Welcome back, #{@@user.name}!".colorize(:black).on_magenta.blink
        else 
            puts ""
            puts "Looks like you haven't studied with us before.".colorize(:black).on_magenta
            sign_up
        end
    end

<<<<<<< HEAD
    def self.sign_up
        puts ""            
=======
    def self.sign_up            
        puts ""
>>>>>>> d4f51accda9950a29e9b4166ad2962206cb30d7b
        puts "Create username:".colorize(:black).on_magenta
        @sign_up = gets.chomp
        @@user = User.create(name: @sign_up)
        if @@user.valid?
            puts ""
            puts "Welcome to Dino Study Guide, #{@@user.name}!".colorize(:black).on_magenta.blink
        else
            try_again
        end
    end

    def self.response
        puts "Please enter 1 or 2: ".red.bold
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
            puts ""
            puts "Looks like that username already exists. Try another one.".colorize(:black).on_magenta
            sign_up
        end
    end

    def self.main_menu
        puts ""
        puts " Main Menu: ".colorize(:black).on_magenta.underline
        puts "What would you like to do today?".colorize(:black).on_magenta
        puts ""
        puts "1. See all dinosaurs.".magenta
        puts "2. See your favorite dinosaurs.".magenta
        puts "3. Quit studying.".magenta
        @response = gets.chomp
        case @response 
        when "1"
            puts ""
            all_dino_list
        when "2"
            puts ""
            see_favs
        when "3"
            puts ""
            puts "Thanks for studying with us today, hope to see you again soon #{@@user.name}!".colorize(:black).on_magenta.blink
        else 
            until @response == "1" || @response == "2" || @response == "3"
                main_menu_response
            end
        end
    end

    def self.all_dino_list
        puts ""
        puts "All Dinosaurs:".black.on_green.blink
        puts ""
        Dinosaur.all.each_with_index { | dino, index | puts "#{index += 1}. #{dino[:name]}".colorize(:green) }
        puts ""
        puts "Type the name of the dinosaur you want more information on.".black.on_green
        puts "Or press enter to return to the Main Menu.".black.on_green
        if !dino_info_card
            main_menu
        end
    end

    def self.dino_info_card
        @response = gets.chomp
        if Dinosaur.find_by(name: @response.capitalize)
            @@found = Dinosaur.find_by(name: @response.capitalize)
            # puts ""
            puts "\n""Name".green.underline + ": #{@@found.name}".green 
            puts "Classification".green.underline + ": #{@@found.classification}".green  
            puts "Diet".green.underline + ": #{@@found.diet}".green 
            puts "Length".green.underline + ": #{@@found.length}".green  
            puts "Height".green.underline + ": #{@@found.height}".green 
            puts "Weight".green.underline + ": #{@@found.weight}".green  
            puts "Location".green.underline + ": #{@@found.location}".green  
            puts "Time Period".green.underline + ": #{@@found.time_period}".green  
            puts "Quick Fact".green.underline + ": #{@@found.fact}".green
            puts ""
            save_favorite
            return true
        else
            return false
        end
    end

    def self.all_dino_helper
        puts "Please enter y or n:".red.bold
        @ans = gets.chomp
        case @ans  
        when "y"
            new_favorite
        when "n"
        end
    end

    def self.see_favs
        if @@user.favorites.count == 0
            puts "Sorry, looks like you don't have any favorites saved.".black.on_cyan
        else
            puts "Your Favorites:".black.on_cyan.blink
            puts ""
            existing_favs_list
            puts ""
            puts "Type name of dinosaur you want more information on.".black.on_cyan
            puts "Or press enter to return to Main Menu.".black.on_cyan
            dino_info_card
            puts ""
        end
        main_menu
    end

    def self.main_menu_response
        puts "Please enter 1, 2, or 3:".red.bold
        @response = gets.chomp
        case @response 
        when "1"
            all_dino_list
        when "2"
            see_favs
        when "3"
            puts ""
            puts "Thanks for studying with us today, hope to see you again soon #{@@user.name}!".colorize(:black).on_magenta.blink
        end
    end

    def self.existing_favs_list
        counter = 1
        @@user.favorites.reload.each do |user_obj| 
            puts "#{counter}. #{user_obj.dinosaur.name}".cyan 
            counter += 1 
        end
    end

    def self.new_favorite
        Favorite.create(user_id: @@user.id, dinosaur_id: @@found.id)
    end

    def self.save_favorite
        puts "Would you like to save this dinosaur as a favorite? y/n".black.on_green
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




    

    
    
    







