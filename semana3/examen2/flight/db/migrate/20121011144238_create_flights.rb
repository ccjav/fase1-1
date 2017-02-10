class CreateFlights < ActiveRecord::Migration
  def change
    create_table :flights do |t|
      t.integer :num_flight
      t.date :date
      t.time :depart
      t.string :from
      t.string :to
      t.time :duration
      t.integer :cost
      t.integer :passengers

      t.timestamps
    end

    create_table :users do |t|
    	t.string :name
      t.string :email
      t.boolean :admin

      t.timestamps
    end

    create_table :users_flights do |t|
      t.integer :flight_id
      t.integer :user_id

      t.timestamps
    end

    create_table :bookings do |t|
      t.integer :num_booking
      t.integer :flight_id
      t.integer :total

      t.timestamps
    end

    create_table :user_bookings do |t|
      t.integer :id_bookings
      t.integer :id_users

      t.timestamps
    end
  end
end
