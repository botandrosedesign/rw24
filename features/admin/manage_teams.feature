Feature: Admins can manage teams
  Background:
    Given today is "2010-06-19"
    And a race exists for 2010
    And the following race teams exist:
      | POS# | Name | Class         | Leader Name | Leader Email          |
      | 001  | BARD | Solo (male)   | Micah       | micah@riverwest24.com |
    And I am logged in as an admin

  Scenario: An Admin views all teams
    When I follow "Races"
    Then I should see the following teams:
      | PAID | EMAILED | POS# | CLASS | TEAM NAME | RIDERS | LEADER NAME |
      | No   | No      | 1    | S     | BARD      | 1      | Micah       |

  Scenario: An admin creates a new team with three members
    When I follow "Races"
    And I follow "New Team"

    When I fill in "Team Name" with "Bot and Rose Design"
    And I select "A Team" from "Category"

    And I fill in "Address" with "625 NW Everett St"
    And I fill in "Line 2" with "#347"
    And I fill in "City" with "Portland"
    And I select "OR" from "State"
    And I fill in "Zip" with "97209"

    And I fill in "Name" with "Micah Geisel" within the first rider
    And I fill in "Email" with "micah@botandrose.com" within the first rider
    And I fill in "Phone" with "937.269.2023" within the first rider
    # And I select "S" from "Shirt Size" within the first rider
    And I fill in "Payment type" with "Cash" within the first rider
    And I check "Paid?" within the first rider

    And I fill in "Name" with "Michael Gubitosa" within the second rider
    And I fill in "Email" with "gubs@botandrose.com" within the second rider
    # And I select "M" from "Shirt Size" within the second rider

    And I fill in "Name" with "Nick Hogle" within the third rider
    And I fill in "Email" with "nick@botandrose.com" within the third rider
    # And I select "L" from "Shirt Size" within the third rider

    And I press "Save"
    Then I should see "The team has been created."

    When I follow "Races"
    Then I should see the following teams:
      | PAID | EMAILED | POS# | CLASS | TEAM NAME           | RIDERS | LEADER NAME  |
      | No   | No      | 1    | S     | BARD                | 1      | Micah        |
      | 1/3  | No      | 2    | A     | Bot and Rose Design | 3      | Micah Geisel |

  Scenario: An Admin edits a team
    When I follow "Races"
    And I follow "Edit" within the "BARD" team

    And I follow "+ Add a rider"
    And I press "Save"
    Then I should see "The rider has been created."

    When I follow "Cancel"
    And I fill in "Name" with "Michael Gubitosa" within the second rider
    And I fill in "Email" with "gubs@botandrose.com" within the second rider
    # And I select "M" from "Shirt Size" within the second rider

    And I select "Tandem" from "Category"
    And I fill in "Team Name" with "Bog and Rat Defeat"
    And I fill in "Address" with "2907 Old Troy Pike"
    And I fill in "Line 2" with ""
    And I fill in "City" with "Dayton"
    And I select "OH" from "State"
    And I fill in "Zip" with "45404"

    And I press "Save"
    Then I should see "The team has been updated."

    When I follow "Races"
    Then I should see the following teams:
      | PAID | EMAILED | POS# | CLASS | TEAM NAME          | RIDERS | LEADER NAME |
      | No   | No      | 1    | T     | Bog and Rat Defeat | 2      | Micah       |

  Scenario: An Admin deletes a team
    When I follow "Races"
    And I follow "Delete" within the "BARD" team
    Then I should see no teams

  Scenario: An Admin deletes a team from the edit page
    When I follow "Races"
    And I follow "Edit" within the "BARD" team
    When I follow "Delete Team"
    Then I should see no teams

