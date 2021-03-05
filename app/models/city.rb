# frozen_string_literal: true

class City < ApplicationRecord
  # Validations
  validates_associated :area
  validates :key, :gmt, :local_name, presence: true
  validates :key, :gmt, numericality: { only_integer: true }
end
