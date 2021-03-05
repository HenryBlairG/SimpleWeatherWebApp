class CitySerializer < ActiveModel::Serializer
   attributes :key, :local_name, :gmt
end
