Feature: Riders can create user accounts that persist beyond races
  Background:
    Given today is "2010-06-19"
    And a race exists for 2010

  Scenario: A rider creates a user account
    Given I am on the homepage
    When I follow "Register"
    And I fill in the following form:
      | Email address         | micah@botandrose.com |
      | Password              | secret               |
      | First name            | Micah                |
      | Last name             | Geisel               |
      | Phone                 | 937.269.2023         |
      | Shirt size            | ML                   |
    And I press "Register"
    Then I should see "A confirmation email has been sent to micah@botandrose.com"

    And "micah@botandrose.com" should receive an email from "info@riverwest24.com" with the subject "Welcome to Riverwest24" and the following body:
      """
      Dear Micah Geisel,<br />
      <br />
      Welcome to Riverwest24!<br />
      <br />
      Please visit the link below to confirm your account.<br />
      """

    When I follow the first link in the email
    Then I should see "Welcome, Micah Geisel! You have completed the registration process."
    And I should not see "Register"
    And I should see "My account"
    And I should see "Logout"

