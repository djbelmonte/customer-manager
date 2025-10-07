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
  
  test "customer birthday format - validation before type casting for the birthday - must be a valid date" do
    customer = customers(:one)
    current_birthday = "05/07/1998".to_date
    
    valid_dates = ["05/07/1998", "12/01/2001", "01/01/2001"]
    invalid_dates = ["-1/30/2009", "99/99/2000", "02/99/2020"]

    valid_dates.each do |date|
      customer.update(birthday: date)
      customer.reload

      assert_equal date.to_date, customer.birthday
    end

    customer.update(birthday: current_birthday)

    invalid_dates.each do |date|
      customer.update(birthday: date)
      customer.reload

      assert_equal current_birthday, customer.birthday
      assert_includes customer.errors[:birthday], "Not a valid date."
    end
  end

  test "customer phone number validation - phone number basic validation - must be around 10-15 digits and may start with +" do
    customer = customers(:one)
    current_phone_number = customer.phone_number
    
    valid_phone_numbers = ["09204049610", "+11234567890", "+442012345678", "0212345678"]
    invalid_phone_numbers = ["12345", "+++123564643", "1241231241212412311234"]

    valid_phone_numbers.each do |phone_number|
      customer.update(phone_number: phone_number)
      customer.reload

      assert_equal phone_number, customer.phone_number
    end

    customer.update(phone_number: current_phone_number)

    invalid_phone_numbers.each do |phone_number|
      customer.update(phone_number: phone_number)
      customer.reload

      assert_equal current_phone_number, customer.phone_number
      assert_includes customer.errors[:phone_number], "Must be a valid phone number (10-15 digits and may start with +)"
    end
  end
end
