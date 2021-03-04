class CreateAreas < ActiveRecord::Migration[6.1]
  def change
    create_table :areas do |t|
      t.string :a_ID
      t.string :a_local_name

      t.timestamps
    end
  end
end
