# frozen_string_literal: true

module API
  module V1
    # Cities Api Controller
    class Cities < Grape::API
      include API::V1::Defaults
      resource :cities do
        desc 'Return all cities'
        get '' do
          City.all
        end
        desc 'Return a city'
        params do
          requires :key, type: String, desc: 'Key of the city'
        end
        get ':key' do
          City.where(key: permitted_params[:key]).first!
        end
      end
    end
  end
end
