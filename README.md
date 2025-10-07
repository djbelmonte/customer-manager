# README

Simple web application that manages customer details given first_name, last_name, birthday and phone_number.
This has a full CRUD functionality.

Built on Ruby on Rails
- Ruby 3.2.2
- Rails 8.0.4
- TailwindCSS

Setup:
- Clone the repository
  ```
  git clone https://github.com/djbelmonte/customer-manager.git
  ```
- Go inside the project
  ```
  cd customer-manager
  ```
- Make sure you have the right ruby and rails installed
  ```
  ruby -v
  rails -v
  ```
- Start server
  ```
  bin/dev
  ```

The app should look like this:

<img width="1917" height="950" alt="image" src="https://github.com/user-attachments/assets/66567fa7-4e8b-46f7-8349-7749a337b478" />


From here, you should be able to test the features including creating customers, updating the details and removing them.

Some restrictions:
- Only English letters, hyphen, apostrophe and spaces are allowed in the customer's name
- Phone number must be a valid one. This has a basic validation to be in between 10-15 digits which is the common phone number in the world and may start with a +
- Birthday must be a valid date and should not be later than the present date


Thank you. Enjoy!
