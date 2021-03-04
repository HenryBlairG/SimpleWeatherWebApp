class Country < ApplicationRecord
  has_many :area, dependent: :destroy
  belongs_to :region
end
