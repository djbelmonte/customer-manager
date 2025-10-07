require "test_helper"

class CustomerTest < ActiveSupport::TestCase
  test "customer has first name, last name, birthday and phone number" do
    customer = customers(:one)

    assert customer.first_name
    assert customer.last_name
    assert customer.birthday
    assert customer.phone_number
  end
end
