class Customer < ApplicationRecord
  validates :first_name, :last_name, :birthday, :phone_number, presence: true

  validates :first_name, :last_name, format: { with: /\A[a-zA-Z][a-zA-Z' -]*\z/, message: "Only English letters, hyphen, apostrophe and spaces are allowed." }
  validate :birthday_should_be_in_the_past


  def birthday_should_be_in_the_past
    if birthday.present? && birthday > Date.today
      errors.add(:birthday, "Birthday should not be later than today.")
    end
  end
end
