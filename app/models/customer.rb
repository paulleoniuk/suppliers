class Customer < ActiveRecord::Base
  VALID_PHONE_NUMBER = /0[569][035-9](\d){7}/

  validates :first_name, presence: true
  validates :first_name, presence: true
  validates :phone, format: { with: VALID_PHONE_NUMBER }, uniqueness: true
  validates :city_id, presence: true

  has_many :orders
  belongs_to :city
end
