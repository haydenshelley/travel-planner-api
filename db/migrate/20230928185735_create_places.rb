class CreatePlaces < ActiveRecord::Migration[7.0]
  def change
    create_table :places do |t|
      t.integer :trip_id
      t.string :address
      t.string :name
      t.text :description
      t.string :image_url
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
