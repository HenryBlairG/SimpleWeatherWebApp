# frozen_string_literal: true

class City < ApplicationRecord
  # Validations
  validates :key, :name, :area, :country, :region, presence: true
  validates :region, uniqueness: { scope: [:country, :area, :name] }
  validates :key, numericality: { only_integer: true }
end
