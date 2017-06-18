class AddCityToBooking < ActiveRecord::Migration
  def change
    add_reference :bookings, :city, index: true
  end
end
