class Booking < ActiveRecord::Base
  belongs_to :city
  belongs_to :customer
  belongs_to :cleaner

  validates :customer, :cleaner, :date, presence: true
end
