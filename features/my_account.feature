Feature: Update my account
  Background:
    Given the following user exists:
      | email                 | micah@botandrose.com |
      | first_name            | Micah                |
      | last_name             | Geisel               |
      | phone                 | 555.111.1111         |
      | shirt_size            | MXL                  |
      | password              | secret               |

    Given I am logged in as "micah@botandrose.com"
    When I follow "My account"

  Scenario: User can update their account
    When I fill in the following form:
      | First name            | Edit                 |
      | Last name             | Name                 |
      | Phone                 | 937.269.2023         |
      | Shirt size            | ML                   |
      | Password              | abc123               |
      | Confirm password      | abc123               |
    And I press "Save My Account"
    Then I should see "Account updated"

    When I follow "My account"
    Then I should see the following form:
      | First name            | Edit                 |
      | Last name             | Name                 |
      | Phone                 | 937.269.2023         |
      | Shirt size            | ML                   |
      | Password              |                      |
      | Confirm password      |                      |

    When I follow "Logout"
    And I follow "Login"
    And I fill in "Email" with "micah@botandrose.com"
    And I fill in "Password" with "secret"
    And I press "Login"

    Then I should see "Could not login with this email and password"
    When I fill in "Password" with "abc123"
    And I press "Login"

    Then I should see "Logged in successfully."

  Scenario: User resets password
    When I follow "Logout"
    And I follow "Login"
    And I follow "Reset your password"
    And I fill in "E-Mail" with "micah@botandrose.com"
    And I press "Reset password"
    And "micah@botandrose.com" should receive an email

    When I open the email with subject "Forgotton Password"
    And I follow the first link in the email
    And I fill in "New password" with "newpassword"
    And I press "Save"
    Then I should see "Your password was changed successfully."

    When I follow "Logout"
    And I follow "Login"
    And I fill in "Email" with "micah@botandrose.com"
    And I fill in "Password" with "newpassword"
    And I press "Login"
    Then I should see "Logged in successfully."
