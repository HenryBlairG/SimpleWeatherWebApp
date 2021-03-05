# frozen_string_literal: true

class Area < ApplicationRecord
  # Associations
  has_many :city, dependent: destroy
  belongs_to :country

  # Validations
  validates_associated :city, :country
  validates :a_ID, :a_local_name, presence: true
end
