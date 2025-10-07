class Customer < ApplicationRecord
  validates :first_name, :last_name, :birthday, :phone_number, presence: true

  validates :first_name, :last_name, format: { with: /\A[a-zA-Z][a-zA-Z' -]*\z/, message: "Only English letters, hyphen, apostrophe and spaces are allowed." }
  validates :phone_number, format: { with: /\A\+?\d{10,15}\z/, message: "Must be a valid phone number (10-15 digits and may start with +)" }
  validate  :birthday_should_be_in_the_past
  validate  :birthday_is_a_valid_date


  def birthday_should_be_in_the_past
    if birthday.present? && birthday > Date.today
      errors.add(:birthday, "Birthday should not be later than today.")
    end
  end

  def birthday_is_a_valid_date
    begin
      birthday_before_type_cast.to_date
    rescue Date::Error
      errors.add(:birthday, "Not a valid date.")
    end
  end
end
