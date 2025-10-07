class CreateCustomers < ActiveRecord::Migration[8.0]
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :last_name
      t.date :birthday
      t.string :phone_number

      t.timestamps
    end
  end
end
