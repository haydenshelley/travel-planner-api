class CreateTrips < ActiveRecord::Migration[7.0]
  def change
    create_table :trips do |t|
      t.integer :user_id
      t.string :title
      t.string :image_url
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
