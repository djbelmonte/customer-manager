require "test_helper"

class CustomersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @customer = customers(:one)
  end

  test "should get index" do
    get customers_url
    assert_response :success

    assert_match "Customers", @response.body
  end

  test "should get new" do
    get new_customer_url
    assert_response :success

    assert_match "New customer", @response.body
  end

  test "should create customer" do
    assert_difference("Customer.count") do
      post customers_url, params: { customer: { birthday: @customer.birthday, first_name: @customer.first_name, last_name: @customer.last_name, phone_number: @customer.phone_number } }
    end

    assert_redirected_to customer_url(Customer.last)
  end

  test "should not create customer - with validation errors" do
    assert_no_difference("Customer.count") do
      post customers_url, params: { customer: { birthday: @customer.birthday, first_name: "Not a valid first name!", last_name: @customer.last_name, phone_number: "1234" } }
    end

    assert_response :unprocessable_entity
    assert_match /Only English letters, hyphen, apostrophe and spaces are allowed/, @response.body
    assert_match /Must be a valid phone number/, @response.body
  end

  test "should show customer" do
    get customer_url(@customer)
    assert_response :success

    @customer.attributes.slice("first_name", "last_name", "phone_number", "birthday").values.each do |text|
      assert_match text.to_s, response.body
    end
  end

  test "should get edit" do
    get edit_customer_url(@customer)
    assert_response :success
  end

  test "should update customer" do
    patch customer_url(@customer), params: { customer: { birthday: @customer.birthday, first_name: @customer.first_name, last_name: @customer.last_name, phone_number: @customer.phone_number } }
    assert_redirected_to customer_url(@customer)
  end

  test "should not update customer - with validation errors" do
    patch customer_url(@customer), params: { customer: { birthday: Date.tomorrow, first_name: @customer.first_name, last_name: @customer.last_name, phone_number: @customer.phone_number } }
    
    assert_response :unprocessable_entity
    assert_match /Birthday should not be later than today/, @response.body
  end

  test "should destroy customer" do
    assert_difference("Customer.count", -1) do
      delete customer_url(@customer)
    end

    assert_redirected_to customers_url
  end
end
