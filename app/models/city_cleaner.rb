class CityCleaner < ActiveRecord::Base
  belongs_to :city
  belongs_to :cleaner

  validates_uniqueness_of :cleaner_id, scope: [:city_id]
end
