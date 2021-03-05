# frozen_string_literal: true

class Region < ApplicationRecord
  # Associations
  has_many :country, dependent: :destroy

  # Validations
  validates_associated :country
  validates :r_ID, :r_local_name, presence: true
end
