class GasStationFinder::Scraper

	def self.scrape_stores(zipcode)
		self.scrape_quiktrip(zipcode)
		self.scrape_loves(zipcode)
    end
    
    def self.scrape_quiktrip(zipcode)
        doc = Nokogiri::HTML(open("https://quiktrip.com/Locations"))
        document.querySelector("#search_button")[0..4].each do |quiktrip|
            store = GasStationFinder::Store.new
            store.name = quiktrip.search("open_bubble").text.strip
			store.address = quiktrip.search("open_bubble").text.strip
            distance_holder = quiktrip.search("open_bubble").text.strip
            store.distance = distance_holder[0..(distance_holder.size)/2-1]
            store.url = "https://quiktrip.com/Locations"
        end

    end

    def self.scrape_loves(zipcode)
        doc = Nokogiri::HTML(open("https://loves.com/en/locations"))
        document.querySelector("#txtDesktopSearch")
        store = GasStationFinder::Store.new
        store.name = loves.search("storeBlock medium").text.strip
        store.address = loves.search("storeBlock medium").text.strip
        distance_holder = loves.search("storeBlock medium").text.strip
        store.distance = distance_holder[0..(distance_holder.size)/2-1]
        store.url = "https://loves.com/en/locations"

    end

end

