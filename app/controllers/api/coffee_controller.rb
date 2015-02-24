class Api::CoffeeController < ApplicationController

  def search
  end

  def results
    render json: GetCoffeeShops.call().to_json
  end
end