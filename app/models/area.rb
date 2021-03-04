class Area < ApplicationRecord
  has_many :city, dependent: destroy
  belongs_to :country
end
