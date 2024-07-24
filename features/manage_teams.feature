Feature: Admins can manage teams
  Background:
    Given today is "2020-06-19"
    And a race exists for 2020
    And the following race teams exist:
      | POS# | Name | Class       | Leader Name | Leader Email          | Address               | City       | State | Zip   |
      | 001  | BARD | Solo (male) | Micah       | micah@riverwest24.com | 214 Rainbow Drive     | Livingston | TX    | 77399 |
      | 002  | BORG | Solo (male) | Michael     | gubs@riverwest24.com  | 625 NW Everett Street | Portland   | OR    | 97209 |
    And I am logged in as an admin
    When I follow "Current Race"

  Scenario: An Admin views all teams
    Then I should see the following teams:
      | PAID | EMAILED | POS# | CLASS | TEAM NAME | RIDERS | T-SHIRTS | LEADER NAME |
      | No   | No      | 1    | S     | BARD      | 1      | 0        | Micah       |
      | No   | No      | 2    | S     | BORG      | 1      | 0        | Michael     |

  Scenario: An admin creates a new team with three members
    When I follow "New Team"

    When I fill in "Team Name" with "Bot and Rose Design"
    And I select "A Team" from "Category"
    And I fill in "S" with "1"
    And I fill in "L" with "2"
    And I fill in "XXL" with "1"

    And I check "Paid?" within the first rider form
    And I fill in "Name" with "Micah Geisel" within the first rider form
    And I fill in "Email" with "micah@botandrose.com" within the first rider form
    And I fill in "Phone" with "937.269.2023" within the first rider form

    And I fill in "Name" with "Michael Gubitosa" within the second rider form
    And I fill in "Email" with "gubs@botandrose.com" within the second rider form

    And I fill in "Name" with "Nick Hogle" within the third rider form
    And I fill in "Email" with "nick@botandrose.com" within the third rider form

    And I press "Save"
    Then I should see "The team has been created."

    When I follow "Current Race" within the admin nav
    Then I should see the following teams:
      | PAID | EMAILED | POS# | CLASS | TEAM NAME           | RIDERS | T-SHIRTS | LEADER NAME  |
      | No   | No      | 1    | S     | BARD                | 1      | 0        | Micah        |
      | No   | No      | 2    | S     | BORG                | 1      | 0        | Michael      |
      | 1/3  | No      | 3    | A     | Bot and Rose Design | 3      | 4        | Micah Geisel |

    And I should see the following shirts count:
      | XS   | 0 |
      | S    | 1 |
      | M    | 0 |
      | L    | 2 |
      | XL   | 0 |
      | XXL  | 1 |
      | XXXL | 0 |

    When I press "Export Teams"
    Then I should download a CSV named "rw24-teams-2020-2020-06-19.csv" with the following contents:
      | Pos | Team Name           | Category    | Address               | Address 2 | City       | State | Zip   | Shirt Total | XS | S | M | L | XL | XXL | XXXL | Rider Pos | Rider Name       | Rider List                                 | Email                 | Phone        | Paid  | Payment type | Notes |
      | 1   | BARD                | Solo (male) | 214 Rainbow Drive     |           | Livingston | TX    | 77399 | 0           | 0  | 0 | 0 | 0 | 0  | 0   | 0    | 1         | Micah            | Micah                                      | micah@riverwest24.com |              | false |              |       |
      | 2   | BORG                | Solo (male) | 625 NW Everett Street |           | Portland   | OR    | 97209 | 0           | 0  | 0 | 0 | 0 | 0  | 0   | 0    | 1         | Michael          | Michael                                    | gubs@riverwest24.com  |              | false |              |       |
      | 3   | Bot and Rose Design | A Team      |                       |           |            |       |       | 4           | 0  | 1 | 0 | 2 | 0  | 1   | 0    | 1         | Micah Geisel     | Micah Geisel, Michael Gubitosa, Nick Hogle | micah@botandrose.com  | 937.269.2023 | true  |              |       |
      | 3   | Bot and Rose Design | A Team      |                       |           |            |       |       | 4           | 0  | 1 | 0 | 2 | 0  | 1   | 0    | 2         | Michael Gubitosa | Micah Geisel, Michael Gubitosa, Nick Hogle | gubs@botandrose.com   |              | false |              |       |
      | 3   | Bot and Rose Design | A Team      |                       |           |            |       |       | 4           | 0  | 1 | 0 | 2 | 0  | 1   | 0    | 3         | Nick Hogle       | Micah Geisel, Michael Gubitosa, Nick Hogle | nick@botandrose.com   |              | false |              |       |

  Scenario: An Admin edits a team
    When I follow "Edit" within the "BARD" team

    And I fill in "Team Name" with "Bog and Rat Defeat"
    And I select "Tandem" from "Category"
    And I fill in "S" with "2"
    And I fill in "Name" with "Michael Gubitosa" within the second rider form
    And I fill in "Email" with "gubs@botandrose.com" within the second rider form
    And I press "Save"
    Then I should see "The team has been updated."

    When I follow "Current Race" within the admin nav
    Then I should see the following teams:
      | PAID | EMAILED | POS# | CLASS | TEAM NAME          | RIDERS | T-SHIRTS | LEADER NAME |
      | No   | No      | 1    | T     | Bog and Rat Defeat | 2      | 2        | Micah       |
      | No   | No      | 2    | S     | BORG               | 1      | 0        | Michael     |

  Scenario: An Admin deletes a team
    When I follow and confirm "Delete" within the "BARD" team
    Then I should see the following teams:
      | PAID | EMAILED | POS# | CLASS | TEAM NAME          | RIDERS | T-SHIRTS | LEADER NAME |
      | No   | No      | 2    | S     | BORG               | 1      | 0        | Michael     |

  Scenario: An Admin deletes a team from the edit page
    When I follow "Edit" within the "BARD" team
    And I follow "Delete Team"
    Then I should see the following teams:
      | PAID | EMAILED | POS# | CLASS | TEAM NAME          | RIDERS | T-SHIRTS | LEADER NAME |
      | No   | No      | 2    | S     | BORG               | 1      | 0        | Michael     |
