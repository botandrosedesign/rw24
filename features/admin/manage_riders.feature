Feature: Admins can manage riders

  Scenario: An Admin views all riders
    Given a solo team exists with name: "Bot and Rose Design"
    And a rider exists with name: "Micah Geisel", team: that team
    And I am logged in as an Admin
    When I follow "Races"
    And I follow "Edit" next to "Bot and Rose Design"
    Then I should see "Micah Geisel"

  Scenario: An Admin creates a rider
    Given an a team exists with name: "Bot and Rose Design"
    And I am logged in as an Admin
    When I follow "Races"
    And I follow "Edit" next to "Bot and Rose Design"
    And I follow "Add a rider"

    When I fill in "Name" with "Michael Gubitosa"
    And I fill in "Email" with "gubs@botandrose.com"
    And I fill in "Phone" with "267.664.0528"
    And I select "L" from "Shirt Size"

    And I check "Paid?"
    And I fill in "Type" with "Cash"
    And I select "June 19th, 2010" as the "Confirmed" date

    And I fill in "Notes" with "this is a test"
    And I press "Save"

    When I follow "Races"
    And I follow "Edit" next to "Bot and Rose Design"
    Then I should see "Michael Gubitosa"

  Scenario: An Admin edits a rider
    Given a solo team exists with name: "Bot and Rose Design"
    And a rider exists with name: "Micah Geisel", team: that team
    And I am logged in as an Admin
    When I follow "Races"
    And I follow "Edit" next to "Bot and Rose Design"
    And I follow "Micah Geisel"

    When I fill in "Name" with "Michael Gubitosa"
    And I fill in "Email" with "gubs@botandrose.com"
    And I fill in "Phone" with "267.664.0528"
    And I select "L" from "Shirt Size"

    And I check "Paid?"
    And I fill in "Type" with "Cash"
    And I select "June 19th, 2010" as the "Confirmed" date

    And I fill in "Notes" with "this is a test"
    And I press "Save"

    When I follow "Races"
    And I follow "Edit" next to "Bot and Rose Design"
    Then I should see "Michael Gubitosa"

  Scenario: An admin deletes a rider
    Given a solo team exists with name: "Bot and Rose Design"
    And a rider exists with name: "Micah Geisel", team: that team
    And I am logged in as an Admin
    When I follow "Races"
    And I follow "Edit" next to "Bot and Rose Design"
    And I follow "Delete" next to "Micah Geisel"

    When I follow "Races"
    And I follow "Edit" next to "Bot and Rose Design"
    Then I should not see "Micah Geisel"

  Scenario: An admin deletes a rider from a rider page
    Given a solo team exists with name: "Bot and Rose Design"
    And a rider exists with name: "Micah Geisel", team: that team
    And I am logged in as an Admin
    When I follow "Races"
    And I follow "Edit" next to "Bot and Rose Design"
    And I follow "Micah Geisel"
    And I follow "Delete"

    When I follow "Races"
    And I follow "Edit" next to "Bot and Rose Design"
    Then I should not see "Micah Geisel"
