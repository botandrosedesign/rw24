Feature: Riders can create user accounts that persist beyond races
  Background:
    Given today is "2010-06-19"
    And a race exists for 2010

  Scenario: A rider creates a user account
    Given I am on the homepage
    When I follow "Register"
    And I fill in the following form:
      | Email address         | micah@botandrose.com |
      | First name            | Micah                |
      | Last name             | Geisel               |
      | Phone                 | 937.269.2023         |
      | Shirt size            | ML                   |
      | Password              | secret               |
      | Confirm password      | seecret              |

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

    When I follow "Logout"
    Then I should see "Register"

  Scenario: Admin creates a new team from existing user profiles
    Given the following users exist:
      | email                | first_name | last_name | phone        | shirt_size |
      | micah@botandrose.com | Micah      | Geisel    | 937.269.2023 | ML         |
      | gubs@botandrose.com  | Michael    | Gubitosa  | 267.664.0528 | MXL        |

    Given I am logged in as an admin
    When I follow "Races"
    And I follow "New Team"

    When I fill in the following form:
      | Team Name | Bot and Rose |
      | Category  | Tandem       |
    Then I should see 2 rider forms

    When I fill in "Search" with "botandrose.com" within the first rider form
    Then I should see the following autocomplete options:
      | Micah Geisel ‹micah@botandrose.com›    |
      | Michael Gubitosa ‹gubs@botandrose.com› |

    When I fill in "Search" with "geisel" within the first rider form
    Then I should see the following autocomplete options:
      | Micah Geisel ‹micah@botandrose.com›    |

    When I select the autocomplete option "Micah Geisel ‹micah@botandrose.com›"
    Then I should see the first rider form filled out with the following:
      | Paid?      |                      |
      | Name       | Micah Geisel         |
      | Email      | micah@botandrose.com |
      | Phone      | 937.269.2023         |
    # | Shirt size | ML                   |

    When I fill in "Search" with "gubs" within the second rider form
    And I select the autocomplete option "gubs@botandrose.com"
    Then I should see the second rider form filled out with the following:
      | Paid?      |                     |
      | Name       | Michael Gubitosa    |
      | Email      | gubs@botandrose.com |
      | Phone      | 267.664.0528        |
    # | Shirt size | MXL                 |

    When I press "Save"
    Then I should see "The team has been created."

    When I follow "2010"
    Then I should see the following teams:
      | PAID | EMAILED | POS# | CLASS | TEAM NAME    | RIDERS | T-SHIRTS | LEADER NAME  |
      | No   | No      | 1    | T     | Bot and Rose | 2      | 0        | Micah Geisel |

