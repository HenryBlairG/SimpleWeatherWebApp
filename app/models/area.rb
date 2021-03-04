class Area < ApplicationRecord
  # Associations
  has_many :city, dependent: destroy
  belongs_to :country
  
  # Validations
  validates_associated :area, :country
  validates :a_ID, :a_local_name, presence: true
end
