class CoffeeController < ApplicationController

  def search
  end

  def results
    url = "https://api.foursquare.com/v2/venues/explore?client_id=#{Figaro.env.foursquare_client_id}&client_secret=#{Figaro.env.foursquare_client_secret}&v=20150224&m=foursquare&near=90026&section=coffee&query=wifi&price=1,2,3"
    response = HTTParty.get(url)
    @shops = response.parsed_response['response']['groups'][0]['items']

    @shops.each do |shop|
      insta_url = "https://api.instagram.com/v1/locations/search?foursquare_v2_id=#{shop['venue']['id']}&client_id=#{Figaro.env.insta_client_id}"
      response = HTTParty.get(insta_url)
      insta_id = response.parsed_response['data'][0]['id']
      
      photos_url = "https://api.instagram.com/v1/locations/#{insta_id}/media/recent?client_id=#{Figaro.env.insta_client_id}"
      response = HTTParty.get(photos_url)

      shop['insta_images'] = response['data']
    end
  end

end