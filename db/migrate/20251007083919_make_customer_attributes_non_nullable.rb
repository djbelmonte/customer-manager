class MakeCustomerAttributesNonNullable < ActiveRecord::Migration[8.0]
  def change
    change_column_null :customers, :first_name, false
    change_column_null :customers, :last_name, false
    change_column_null :customers, :birthday, false
    change_column_null :customers, :phone_number, false
  end
end
