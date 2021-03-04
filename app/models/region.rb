class Region < ApplicationRecord
  has_many :country, dependent: :destroy
end
