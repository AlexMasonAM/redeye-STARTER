class GetCoffeeShops
  # see unrefactored code commented below
  def self.call
    @shops = fsq_results

    @shops.each do |shop|
      id = get_instagram_location_id(shop['venue']['id'])
      shop['insta_images'] = get_instagram_images(id)    
    
    end

    return @shops
  end

private

  ######## HTTP Logic ###########
  def self.fsq_results
    foursquare_response = HTTParty.get(foursquare_url) 
    json = JSON.parse(foursquare_response)
    @shops = json['response']['groups'][0]['items'].first(2)
  end

  def self.get_instagram_location_id(foursquare_id)
    response = HTTParty.get( instagram_search_url(foursquare_id))
    return response.parsed_response['data'][0]['id']
  end
  
  def self.get_instagram_images(instagram_id)
    response = HTTParty.get( instagram_photos_url(instagram_id) )
    return response['data']
  end

  ######## URLS ###########

  def self.foursquare_url
  # url = "https://api.foursquare.com/v2/venues/explore?client_id=#{Figaro.env.foursquare_client_id}&client_secret=#{Figaro.env.foursquare_client_secret}&v=20150224&m=foursquare&near=90026&section=coffee&query=wifi&price=1,2,3"
    "https://gist.githubusercontent.com/thebucknerlife/f90591e366f0f7997702/raw/a4e6cc800e4a50dac093102b6452f62884bad96a/foursquare_spoof.json"
  end

  def self.instagram_search_url(foursquare_id)
    "https://api.instagram.com/v1/locations/search?foursquare_v2_id=#{foursquare_id}&client_id=#{Figaro.env.insta_client_id}"
  end

  def self.instagram_photos_url(instagram_business_id)
    "https://api.instagram.com/v1/locations/#{instagram_business_id}/media/recent?client_id=#{Figaro.env.insta_client_id}"
  end

end


# class GetCoffeeShops
#   # see unrefactored code commented below
#   def self.call
#     response = HTTParty.get(foursquare_url)
#     json = JSON.parse(response)
#     @shops = json['response']['groups'][0]['items'].first(2)

#     @shops.each do |shop|
      
#       response = HTTParty.get( instagram_search_url(shop['venue']['id']) )
#       insta_id = response.parsed_response['data'][0]['id']
      
#       response = HTTParty.get( instagram_photos_url(insta_id) )

#       shop['insta_images'] = response['data']
#     end
#     return @shops
#   end

# private

#   def self.foursquare_url
#   # url = "https://api.foursquare.com/v2/venues/explore?client_id=#{Figaro.env.foursquare_client_id}&client_secret=#{Figaro.env.foursquare_client_secret}&v=20150224&m=foursquare&near=90026&section=coffee&query=wifi&price=1,2,3"
#     "https://gist.githubusercontent.com/thebucknerlife/f90591e366f0f7997702/raw/a4e6cc800e4a50dac093102b6452f62884bad96a/foursquare_spoof.json"
#   end

#   def self.instagram_search_url(foursquare_id)
#     "https://api.instagram.com/v1/locations/search?foursquare_v2_id=#{foursquare_id}&client_id=#{Figaro.env.insta_client_id}"
#   end

#   def self.instagram_photos_url(instagram_business_id)
#     "https://api.instagram.com/v1/locations/#{instagram_business_id}/media/recent?client_id=#{Figaro.env.insta_client_id}"
#   end

# end



# unrefactored code
 # def self.call
 #    # WORKS with FOURSQUARE api 
 #    # url = "https://api.foursquare.com/v2/venues/explore?client_id=#{Figaro.env.foursquare_client_id}&client_secret=#{Figaro.env.foursquare_client_secret}&v=20150224&m=foursquare&near=90026&section=coffee&query=wifi&price=1,2,3"
 #    # response = HTTParty.get(url)
 #    # @shops = response.parsed_response['response']['groups'][0]['items']

 #    # Simulates FOURSQUARE request
 #    url = "https://gist.githubusercontent.com/thebucknerlife/f90591e366f0f7997702/raw/a4e6cc800e4a50dac093102b6452f62884bad96a/foursquare_spoof.json"
 #    response = HTTParty.get(url)
 #    json = JSON.parse(response)
 #    # @shops = json['response']['groups'][0]['items']
 #    # gets first two objects from the response array
 #    @shops = json['response']['groups'][0]['items'].first(2)

 #    @shops.each do |shop|
 #      insta_url = "https://api.instagram.com/v1/locations/search?foursquare_v2_id=#{shop['venue']['id']}&client_id=#{Figaro.env.insta_client_id}"
 #      response = HTTParty.get(insta_url)
 #      insta_id = response.parsed_response['data'][0]['id']
      
 #      photos_url = "https://api.instagram.com/v1/locations/#{insta_id}/media/recent?client_id=#{Figaro.env.insta_client_id}"
 #      response = HTTParty.get(photos_url)

 #      shop['insta_images'] = response['data']
 #    end
 #    return @shops
 #  end
