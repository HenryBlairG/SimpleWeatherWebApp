# frozen_string_literal: true

# City Api Serializer
class CitySerializer < ActiveModel::Serializer
  attributes :key, :name, :area, :country, :region
end
