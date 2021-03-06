class RemoveCityGmt < ActiveRecord::Migration[6.1]
  def change
    remove_columns :cities, :gmt
  end
end
