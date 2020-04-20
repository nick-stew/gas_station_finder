class GasStationFinder::CLI
	attr_accessor :zipcode
	@@zipcode = nil
	
	def call
        puts <<-DOC
        
---------------------------
Welcome to Gas Station Finder!
Please enter your 5 digit US zip code:
---------------------------
		DOC
		zipcode
		GasStationFinder::Scraper.scrape_stores(@@zipcode)
		list_stores
		menu
        goodbye
        
    end

    def zipcode
		@@zipcode = gets.strip
	end

	def list_stores
		puts ""
		puts "Here are the locations of the nearest gas statioins:"

		GasStationFinder::Store.sort_stores_by_distance.each.with_index(1) do |store, i|
			puts "#{i}. #{store.name} - #{store.address} - is #{store.distance} away."
			puts ""
		end
    end
    
    def menu
		choice = nil
		while choice != "exit"
			puts "Select a location to get more info (or you can type list or exit):"
			choice = gets.strip.downcase
			
			if choice.to_i > 0 && choice.to_i <= GasStationFinder::Store.sort_stores_by_distance.size
				my_store = GasStationFinder::Store.sort_stores_by_distance[choice.to_i-1]
				puts "    #{my_store.name} - #{my_store.address} - #{my_store.distance}"
                puts "    ----#{my_store.url}"
			elsif choice == "list"
				list_stores
			else
				puts "Please try again, or type list or exit." unless choice == "exit"
			end
		end
	end

	def goodbye
		puts "Thank you for using Gas Station Finder! Don't forget to pick up a fountain drink and a snack for your trip!
		"
	end
end