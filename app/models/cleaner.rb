class Cleaner < ActiveRecord::Base
  has_many :city_cleaners
  has_many :cities, through: :city_cleaners

  validates :first_name, :last_name, :quality_score, presence: true

  validates :quality_score, inclusion:  0.0..5.0
end
