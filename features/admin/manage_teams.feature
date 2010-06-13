Feature: Admins can manage teams

  Scenario: An Admin views all teams
    Given a solo team exists with name: "Bot and Rose Design"
    And a rider exists with name: "Micah Geisel", team: that team
    And I am logged in as an Admin
    When I follow "Races"
    Then I should see 1 team
    And I should see "Bot and Rose Design"
    And I should see "Micah Geisel"

  Scenario: An Admin edits a team
    Given a solo team exists with name: "Bot and Rose Design"
    And a rider exists with name: "Micah Geisel", team: that team
    And I am logged in as an Admin
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
