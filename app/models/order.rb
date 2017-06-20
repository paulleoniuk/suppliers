class Order < ActiveRecord::Base
  validates :date, presence: true
  validates :city_id, presence: true
  validates :customer_id, presence: true
  validates :supplier_id, presence: true

  belongs_to :customer
  belongs_to :supplier
  belongs_to :city
end
