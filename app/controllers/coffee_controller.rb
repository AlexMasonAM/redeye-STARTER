class CoffeeController < ApplicationController

  def search
  end

  def results
    @shops = GetCoffeeShops.call()
  end

end