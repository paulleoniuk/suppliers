class CreateSuppliers < ActiveRecord::Migration
  def change
    create_table :suppliers do |t|
      t.string :first_name
      t.string :last_name
      t.string :product_name
      t.string :phone
      t.string :compony
      t.references :city, index: true

      t.timestamps null: false
    end
  end
end
