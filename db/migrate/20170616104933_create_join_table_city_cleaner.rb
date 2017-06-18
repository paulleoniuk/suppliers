class CreateJoinTableCityCleaner < ActiveRecord::Migration
  def change
    create_table :city_cleaners do |t|
      t.integer :city_id
      t.integer :cleaner_id

      t.index [:city_id, :cleaner_id]
      t.index [:cleaner_id, :city_id]
    end
  end
end
