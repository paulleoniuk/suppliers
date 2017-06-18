class Customer < ActiveRecord::Base
  belongs_to :city
  validates :first_name, :last_name, presence: true
end
