Feature: Admins can manage riders

  Scenario: An Admin views all riders
    Given a solo team exists with name: "Bot and Rose Design"
    And a rider exists with name: "Micah Geisel", team: that team
    And I am logged in as an Admin
    When I follow "Races"
    And I follow "Edit" next to "Bot and Rose Design"
    Then I should see "Micah Geisel"

  Scenario: An Admin edits all riders
    Given a team exists with name: "Bot and Rose Design"
    Then 2 riders should exist with team: that team
    And I am logged in as an Admin
    When I follow "Races"
    And I follow "Edit" next to "Bot and Rose Design"
    
    When I fill in "Name" with "Paul Kjelland" for "Rider 1"
    And I fill in "Email" with "paulkjell@gmail.com" for "Rider 1"
    And I fill in "Phone" with "608.558.5276" for "Rider 1"
    And I select "S" from "Shirt Size" for "Rider 1"

    And I check "Paid?" for "Rider 1"
    And I fill in "Payment type" with "Cash" for "Rider 1"
    And I select "August 1st, 2010" as the "Confirmed" date for "Rider 1"

    And I fill in "Notes" with "Rider 1" for "Rider 1"

    When I fill in "Name" with "Steve Whitlow" for "Rider 2"
    And I fill in "Email" with "swirr2@gmail.com" for "Rider 2"
    And I fill in "Phone" with "414.517.6870" for "Rider 2"
    And I select "M" from "Shirt Size" for "Rider 2"

    And I uncheck "Paid?" for "Rider 2"
    And I fill in "Payment type" with "Check" for "Rider 2"
    And I select "August 2nd, 2010" as the "Confirmed" date for "Rider 2"

    And I fill in "Notes" with "Rider 2" for "Rider 2"

    And I press "Save"

    Then 2 riders should exist with team: that team
    And the following riders should exist:
      | name          | email               | phone        | shirt | paid  | payment_type | confirmed_on     | notes   |
      | Paul Kjelland | paulkjell@gmail.com | 608.558.5276 | S     | true  | Cash         | August 1st, 2010 | Rider 1 |
      | Steve Whitlow | swirr2@gmail.com    | 414.517.6870 | M     | false | Check        | August 2nd, 2010 | Rider 2 |

  Scenario: An Admin creates a rider
    Given a team exists with name: "Bot and Rose Design"
    And I am logged in as an Admin
    When I follow "Races"
    And I follow "Edit" next to "Bot and Rose Design"
    And I follow "Add a rider"

    When I fill in "Name" with "Michael Gubitosa"
    And I fill in "Email" with "gubs@botandrose.com"
    And I fill in "Phone" with "267.664.0528"
    And I select "L" from "Shirt Size"

    And I check "Paid?"
    And I fill in "Payment type" with "Cash"
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
    And I fill in "Payment type" with "Cash"
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
    And I follow "Delete Micah Geisel"

    When I follow "Races"
    And I follow "Edit" next to "Bot and Rose Design"
    Then I should not see "Micah Geisel"
