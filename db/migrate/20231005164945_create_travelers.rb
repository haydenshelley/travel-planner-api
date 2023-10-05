class CreateTravelers < ActiveRecord::Migration[7.0]
  def change
    create_table :travelers do |t|
      t.integer :user_id
      t.integer :trip_id
      t.boolean :admin
      t.boolean :accepted

      t.timestamps
    end
  end
end
