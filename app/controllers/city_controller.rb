class CityController < ApplicationController

  def index   # R
    @cities = City.all
  end

  def forecast
  end
end
