Feature: Admins can manage teams
  Background:
    Given today is "2020-06-19"
    And a race exists for 2020
    And the following race teams exist:
      | POS# | Name | Class         | Leader Name | Leader Email          |
      | 001  | BARD | Solo (male)   | Micah       | micah@riverwest24.com |
      | 002  | BORG | Solo (male)   | Michael     | gubs@riverwest24.com  |
    And I am logged in as an admin

  Scenario: An Admin views all teams
    When I follow "Races"
    Then I should see the following teams:
      | PAID | EMAILED | POS# | CLASS | TEAM NAME | RIDERS | T-SHIRTS | LEADER NAME |
      | No   | No      | 1    | S     | BARD      | 1      | 0        | Micah       |
      | No   | No      | 2    | S     | BORG      | 1      | 0        | Michael     |

  Scenario: An admin creates a new team with three members
    When I follow "Races"
    And I follow "New Team"

    When I fill in "Team Name" with "Bot and Rose Design"
    And I select "A Team" from "Category"
    And I fill in "Mens large" with "2"
    And I fill in "Mens xx large" with "1"
    And I fill in "Womens small" with "1"

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

    When I follow "Races"
    Then I should see the following teams:
      | PAID | EMAILED | POS# | CLASS | TEAM NAME           | RIDERS | T-SHIRTS | LEADER NAME  |
      | No   | No      | 1    | S     | BARD                | 1      | 0        | Micah        |
      | No   | No      | 2    | S     | BORG                | 1      | 0        | Michael      |
      | 1/3  | No      | 3    | A     | Bot and Rose Design | 3      | 4        | Micah Geisel |

    And I should see the following shirts count:
      | Mens Small       | 0 |
      | Mens Medium      | 0 |
      | Mens Large       | 2 |
      | Mens X Large     | 0 |
      | Mens Xx Large    | 1 |
      | Mens Xxx Large   | 0 |
      | Womens Small     | 1 |
      | Womens Medium    | 0 |
      | Womens Large     | 0 |
      | Womens X Large   | 0 |
      | Womens Xx Large  | 0 |
      | Womens Xxx Large | 0 |

# Scenario: An Admin edits a team
#   When I follow "Races"
#   And I follow "Edit" within the "BARD" team

#   And I fill in "Team Name" with "Bog and Rat Defeat"
#   And I select "Tandem" from "Category"
#   And I fill in "Mens small" with "2"
#   And I fill in "Name" with "Michael Gubitosa" within the second rider form
#   And I fill in "Email" with "gubs@botandrose.com" within the second rider form
#   And I press "Save"
#   Then I should see "The team has been updated."

#   When I follow "Races"
#   Then I should see the following teams:
#     | PAID | EMAILED | POS# | CLASS | TEAM NAME          | RIDERS | T-SHIRTS | LEADER NAME |
#     | No   | No      | 1    | T     | Bog and Rat Defeat | 2      | 2        | Micah       |
#     | No   | No      | 2    | S     | BORG               | 1      | 0        | Michael     |

  Scenario: An Admin deletes a team
    When I follow "Races"
    And I follow and confirm "Delete" within the "BARD" team
    Then I should see the following teams:
      | PAID | EMAILED | POS# | CLASS | TEAM NAME          | RIDERS | T-SHIRTS | LEADER NAME |
      | No   | No      | 2    | S     | BORG               | 1      | 0        | Michael     |

  Scenario: An Admin deletes a team from the edit page
    When I follow "Races"
    And I follow "Edit" within the "BARD" team
    When I follow "Delete Team"
    Then I should see the following teams:
      | PAID | EMAILED | POS# | CLASS | TEAM NAME          | RIDERS | T-SHIRTS | LEADER NAME |
      | No   | No      | 2    | S     | BORG               | 1      | 0        | Michael     |

