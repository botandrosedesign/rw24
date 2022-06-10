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

  # Scenario: Admin can see all users
    Given I am logged in as an admin
    When I follow "Users"
    Then I should see the following users:
      | NAME          | EMAIL                 | CONFIRMED? | ROLE      | RACES | SHIRT |
      | Admin Account | admin@riverwest24.com | Yes        | Superuser |       |       |
      | Micah Geisel  | micah@botandrose.com  | Yes        |           |       | ML    |

  # Scenario: Admin can download all users
    When I follow "Download users"
    Then I should download a CSV named "rw24-users-2020-06-19.csv" with the following contents:
      | Name          | Email                 | Confirmed? | Role      | Races | Shirt |
      | Admin Account | admin@riverwest24.com | Yes        | Superuser |       |       |
      | Micah Geisel  | micah@botandrose.com  | Yes        |           |       | ML    |

  Scenario: Same email can't be used to create profile
    Given the following users exist:
      | email                |
      | micah@botandrose.com |

    Given I am on the homepage
    When I follow "Create profile"
    And I fill in the following form:
      | Email address         | micah@botandrose.com |
      | First name            | Micah                |
      | Last name             | Geisel               |
      | Phone                 | 937.269.2023         |
      | Shirt size            | ML                   |
      | Password              | abc123               |
      | Confirm password      | abc123               |

    And I press "Create Rider Profile"
    Then I should see "Email has already been taken"

  Scenario: Trying to create a profile with unconfirmed email resends link
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
    And "micah@botandrose.com" should receive an email from "info@riverwest24.com"

    Given a clear email queue
    And I am on the homepage
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
    Then I should see "Profile already exists but is unconfirmed. A confirmation email has been sent to micah@botandrose.com"
    And "micah@botandrose.com" should receive an email from "info@riverwest24.com" with the subject "Welcome to Riverwest24" and the following body:
      """
      Dear Micah Geisel,<br />
      <br />
      Welcome to Riverwest24!<br />
      <br />
      Please visit the link below to confirm your account.<br />
      """

  Scenario: Trying to login with unconfirmed email resends link
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

    And I follow "Login"
    And I fill in "Email" with "micah@botandrose.com"
    And I fill in "Password" with "secret"
    And I press "Login"
    Then I should see "Profile already exists but is unconfirmed. A confirmation email has been sent to micah@botandrose.com"
    And "micah@botandrose.com" should receive an email from "info@riverwest24.com" with the subject "Welcome to Riverwest24" and the following body:
      """
      Dear Micah Geisel,<br />
      <br />
      Welcome to Riverwest24!<br />
      <br />
      Please visit the link below to confirm your account.<br />
      """

  Scenario: Admin can resend confirmation
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
    And "micah@botandrose.com" should receive an email from "info@riverwest24.com"

    Given a clear email queue
    And I am logged in as an admin
    When I follow "Users"
    Then I should see the following users:
      | NAME              | EMAIL                 | CONFIRMED? | ROLE      | RACES | SHIRT |
      | Admin Account     | admin@riverwest24.com | Yes        | Superuser |       |       |
      | Micah Geisel      | micah@botandrose.com  | Resend     |           |       | ML    |
    When I follow "Resend"
    Then I should see "Confirmation email resent to micah@botandrose.com"
    And "micah@botandrose.com" should receive an email from "info@riverwest24.com"

    Given a clear email queue
    When I follow "Races"
    And I follow "New Team"

    When I fill in the following form:
      | Team Name | Bot and Rose |
      | Category  | Solo (male)  |

    When I type "botandrose.com" into "Search" within the first rider form
    Then I should see the following autocomplete options:
      | UNCONFIRMED Micah Geisel ‹micah@botandrose.com›    |
    When I select the autocomplete option "UNCONFIRMED Micah Geisel ‹micah@botandrose.com›"
    Then I should see the first rider form filled out with the following:
      | Paid?      |                      |
      | Name       |                      |
      | Email      |                      |
      | Phone      |                      |
      | Shirt size |                      |
    And I should see "Confirmation email resent to micah@botandrose.com"
    And "micah@botandrose.com" should receive an email from "info@riverwest24.com" with the subject "Welcome to Riverwest24" and the following body:
      """
      Dear Micah Geisel,<br />
      <br />
      Welcome to Riverwest24!<br />
      <br />
      Please visit the link below to confirm your account.<br />
      """

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

    When I type "botandrose.com" into "Search" within the first rider form
    Then I should see the following autocomplete options:
      | Micah Geisel ‹micah@botandrose.com›    |
      | Michael Gubitosa ‹gubs@botandrose.com› |

    When I type "geisel" into "Search" within the first rider form
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

    When I type "gubs" into "Search" within the second rider form
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

    When I follow "New Team"
    And I fill in the following form:
      | Team Name | Not Again     |
      | Category  | Solo (male)   |

    When I type "botandrose.com" into "Search" within the first rider form
    Then I should see the following autocomplete options:
      | #1 Micah Geisel ‹micah@botandrose.com›    |
      | #1 Michael Gubitosa ‹gubs@botandrose.com› |

    When I follow "Users"
    Then I should see the following users:
      | NAME              | EMAIL                 | CONFIRMED? | ROLE      | RACES | SHIRT |
      | Admin Account     | admin@riverwest24.com | Yes        | Superuser |       |       |
      | Micah Geisel      | micah@botandrose.com  | Yes        |           | 2020  | ML    |
      | Michael Gubitosa  | gubs@botandrose.com   | Yes        |           | 2020  | MXL   |

  # Scenario: Admin can download all users
    When I follow "Download users"
    Then I should download a CSV named "rw24-users-2020-06-19.csv" with the following contents:
      | Name              | Email                 | Confirmed? | Role      | Races | Shirt |
      | Admin Account     | admin@riverwest24.com | Yes        | Superuser |       |       |
      | Micah Geisel      | micah@botandrose.com  | Yes        |           | 2020  | ML    |
      | Michael Gubitosa  | gubs@botandrose.com   | Yes        |           | 2020  | MXL   |

