Feature: Admins can manage teams
  Background:
    Given a solo team exists with name: "Bot and Rose Design"
    And a rider exists with name: "Micah Geisel", team: that team
    And I am logged in as an Admin

  Scenario: An Admin views all teams
    When I follow "Races"
    Then I should see 1 team
    And I should see "Bot and Rose Design"
    # And I should see "Micah Geisel"

  Scenario: An admin creates a new team with three members
    When I follow "Races"
    And I follow "New"

    When I fill in "Team Name" with "Bot and Rose Design"
    And I select "A Team" from "Category"

    And I fill in "Address" with "625 NW Everett St"
    And I fill in "Line 2" with "#347"
    And I fill in "City" with "Portland"
    And I select "OR" from "State"
    And I fill in "Zip" with "97209"

    And I fill in "Name" under "Rider 1" with "Micah Geisel"
    And I fill in "Email" under "Rider 1" with "micah@botandrose.com"
    And I fill in "Phone" under "Rider 1" with "937.269.2023"
    And I fill in "Shirt" under "Rider 1" with "S"
    And I fill in "Type" under "Rider 1" with "Cash"
    And I check "Paid?" under "Rider 1"

    And I fill in "Name" under "Rider 2" with "Michael Gubitosa"
    And I fill in "Email" under "Rider 2" with "gubs@botandrose.com"
    And I fill in "Shirt" under "Rider 2" with "L"

    And I fill in "Name" under "Rider 3" with "Nick Hogle"
    And I fill in "Email" under "Rider 3" with "nick@botandrose.com"
    And I fill in "Shirt" under "Rider 3" with "M"

    And I press "Save"

    When I follow "Races"
    Then I should see 2 team
    And I should see "Bot and Rose Design"
    And I should see "1/3"
    And I should see "A"
    And I should see "3"
    And I should see "Micah Geisel"

  Scenario: An Admin edits a team
    When I follow "Races"
    And I follow "Edit" next to "Bot and Rose Design"

    And I select "Tandem" from "Category"
    And I fill in "Team Name" with "Bog and Rat Defeat"
    And I fill in "Address" with "2907 Old Troy Pike"
    And I fill in "Line 2" with ""
    And I fill in "City" with "Dayton"
    And I select "OH" from "State"
    And I fill in "Zip" with "45404"
    And I press "Save"

    When I follow "Races"
    Then I should see 1 team
    And I should see "Bog and Rat Defeat"

  Scenario: An Admin deletes a team
    When I follow "Races"
    And I follow "Delete"
    Then I should see 0 teams
    And I should not see "Bot and Rose Design"

  Scenario: An Admin deletes a team from the edit page
    When I follow "Races"
    And I follow "Edit" next to "Bot and Rose Design"

    When I follow "Delete"
    Then I should see 0 teams
    And I should not see "Bot and Rose Design"
