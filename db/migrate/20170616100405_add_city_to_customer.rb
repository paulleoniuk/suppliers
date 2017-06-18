class AddCityToCustomer < ActiveRecord::Migration
  def change
    add_reference :customers, :city, index: true
  end
end
