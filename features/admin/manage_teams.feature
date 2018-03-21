Feature: Admins can manage teams
  Background:
    Given today is "2010-06-19"
    And a race exists for 2010
    And a solo team exists with name: "Bot and Rose Design"
    And a rider exists with name: "Micah Geisel", team: that team
    And I am logged in as an admin

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

    When I follow "Races"
    Then I should see 2 team
    And I should see "Bot and Rose Design"
    And I should see "1/3"
    And I should see "A"
    And I should see "3"
    And I should see "Micah Geisel"

  Scenario: An Admin edits a team
    When I follow "Races"
    And I follow "Edit" within the "Bot and Rose Design" team

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
    And I follow "Edit" within the "Bot and Rose Design" team

    When I follow "Delete"
    Then I should see no teams
    And I should not see "Bot and Rose Design"
