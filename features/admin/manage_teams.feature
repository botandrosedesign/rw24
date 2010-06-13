Feature: Admins can manage teams

  Scenario: An Admin views all teams
    Given a solo team exists with name: "Bot and Rose Design"
    And a rider exists with name: "Micah Geisel", team: that team
    And I am logged in as an Admin
    When I follow "Races"
    Then I should see 1 team
    And I should see "Bot and Rose Design"
    And I should see "Micah Geisel"
