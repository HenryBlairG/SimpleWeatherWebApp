class City < ApplicationRecord
  # Associations
  belongs_to :area

  # Validations
  validates_associated :area
  validates :key, :gmt, :local_name, presence: true 
  validates :key, :gmt, numericality: { only_integer: true } 
end
