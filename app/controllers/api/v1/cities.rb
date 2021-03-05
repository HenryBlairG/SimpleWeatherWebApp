require('rest-client')
require('json')

module API
  module V1
    # Cities Api Controller
    class Cities < Grape::API
      include API::V1::Defaults

      apikey = ENV["WEATHER_API_KEY"]
      
      resource :cities do

        desc 'Return all cities'
        get '' do
          City.all
        end

        desc 'Return City Forecast'
        params do
          requires :key, type: String, desc: 'Key of the city'
        end
        get ':key' do
          qry = "http://dataservice.accuweather.com/forecasts/v1/daily/5day/#{permitted_params[:key]}?apikey=#{apikey}&metric=true"
          rsp = RestClient.get(qry, headers: {})
          rsp.body
        end

        desc 'Find City By Name'
        params do
          requires :text, type: String, desc: 'Name to find'
        end
        get 'find/:text' do
          qry = "http://dataservice.accuweather.com/locations/v1/cities/search?apikey=#{apikey}&q=#{permitted_params[:text]}"
          rsp = RestClient.get(qry, headers: {})
          obj = JSON.parse(rsp.body, symbolize_keys: true)
          found = obj.map do |o|
            {
              key:                                     o["Key"],
              name:                          o["LocalizedName"],
              area:    o["AdministrativeArea"]["LocalizedName"],
              country:            o["Country"]["LocalizedName"],
              region:              o["Region"]["LocalizedName"]
            }
          end
          JSON.generate(found)
        end

        desc 'Create City'
        params do
          requires :key,     type: String, desc: 'City Key'
          requires :name,    type: String, desc: 'City Name'
          requires :area,    type: String, desc: 'City Area'
          requires :country, type: String, desc: 'City Country'
          requires :region,  type: String, desc: 'City Region'
        end
        post 'create' do
          City.create(params)
        end

      end

      
    end
  end
end
