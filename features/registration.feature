Feature: Riders can create user accounts that persist beyond races
  Background:
    Given today is "2020-06-19"
    And a race exists for 2020

  Scenario: A rider creates a user account
    Given I am on the homepage
    When I follow "Create profile"
    And I fill in the following form:
      | Email address         | micah@botandrose.com |
      | First name            | Micah                |
      | Last name             | Geisel               |
      | Phone                 | 937.269.2023         |
      | Shirt size            | ML                   |
      | Password              | secret               |
      | Confirm password      | secret               |

    And I press "Create Rider Profile"
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
    Then I should see "Welcome, Micah Geisel! You have created your profile."
    And I should not see "CREATE PROFILE"
    And I should see "MY ACCOUNT"
    And I should see "LOGOUT"

    When I follow "My account"
    Then I should see "EMAIL micah@botandrose.com"
    And I should see the following form:
      | First name            | Micah                |
      | Last name             | Geisel               |
      | Phone                 | 937.269.2023         |
      | Shirt size            | ML                   |
      | Password              |                      |
      | Confirm password      |                      |

    When I follow "Logout"
    Then I should see "CREATE PROFILE"

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
      | Shirt size | ML                   |

    And I should see the following mens shirt sizes:
      | Mens small      | 0 |
      | Mens medium     | 0 |
      | Mens large      | 1 |
      | Mens x large    | 0 |
      | Mens xx large   | 0 |
      | Mens xxx large  | 0 |

    When I fill in "Search" with "gubs" within the second rider form
    And I select the autocomplete option "gubs@botandrose.com"
    Then I should see the second rider form filled out with the following:
      | Paid?      |                     |
      | Name       | Michael Gubitosa    |
      | Email      | gubs@botandrose.com |
      | Phone      | 267.664.0528        |
      | Shirt size | MXL                 |

    And I should see the following mens shirt sizes:
      | Mens small      | 0 |
      | Mens medium     | 0 |
      | Mens large      | 1 |
      | Mens x large    | 1 |
      | Mens xx large   | 0 |
      | Mens xxx large  | 0 |

    When I press "Save"
    Then I should see "The team has been created."

    When I follow "2020"
    Then I should see the following teams:
      | PAID | EMAILED | POS# | CLASS | TEAM NAME    | RIDERS | T-SHIRTS | LEADER NAME  |
      | No   | No      | 1    | T     | Bot and Rose | 2      | 2        | Micah Geisel |

    And I should see the following shirts count:
      | Mens Small       | 0 |
      | Mens Medium      | 0 |
      | Mens Large       | 1 |
      | Mens X Large     | 1 |
      | Mens Xx Large    | 0 |
      | Mens Xxx Large   | 0 |
      | Womens Small     | 0 |
      | Womens Medium    | 0 |
      | Womens Large     | 0 |
      | Womens X Large   | 0 |
      | Womens Xx Large  | 0 |
      | Womens Xxx Large | 0 |

