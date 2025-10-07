require "test_helper"

class CustomerTest < ActiveSupport::TestCase
  test "customer has first name, last name, birthday and phone number" do
    customer = customers(:one)

    assert customer.first_name
    assert customer.last_name
    assert customer.birthday
    assert customer.phone_number
  end
  
  test "customer first_name and last_name validation" do
    customer = customers(:one)

    valid_names = ["Donn Jerico", "Donn", "Donn-Jerico", "Marc O'neal"]
    invalid_names = ["Tom & Jerry", "Donn!", "@Donn" "   Donn"]

    valid_names.each do |name|
      customer.update(first_name: name, last_name: name)
      customer.reload

      assert_equal name, customer.first_name
      assert_equal name, customer.last_name
    end
    
    customer.update(first_name: "Customer", last_name: "One")

    invalid_names.each do |name|
      customer.update(first_name: name, last_name: name)
      customer.reload

      assert_equal "Customer", customer.first_name
      assert_equal "One", customer.last_name

      assert_includes customer.errors[:first_name], "Only English letters, hyphen, apostrophe and spaces are allowed."
      assert_includes customer.errors[:last_name], "Only English letters, hyphen, apostrophe and spaces are allowed."
    end
  end

  test "customer birthday validation - customer's birthday can only be from past to present" do
    customer = customers(:one)
    current_birthday = customer.birthday

    customer.update(birthday: Date.tomorrow)
    customer.reload
    assert_equal current_birthday, customer.birthday
    assert_includes customer.errors[:birthday], "Birthday should not be later than today."

    customer.update(birthday: Date.yesterday)
    customer.reload
    assert_equal Date.yesterday, customer.birthday

    customer.update(birthday: Date.today)
    customer.reload
    assert_equal Date.today, customer.birthday
  end
end
