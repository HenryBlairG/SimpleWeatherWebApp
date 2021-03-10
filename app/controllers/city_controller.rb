class CityController < ApplicationController

  def index   # R
    @cities = City.all
  end

  def destroy  # D
  end

  def forecast
  end
end
