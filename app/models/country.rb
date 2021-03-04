class Country < ApplicationRecord
  # Associations
  has_many :area, dependent: :destroy
  belongs_to :region

  # Validations
  validates_associated :area, :region
  validates :c_ID, :c_local_name, presence: true
end
