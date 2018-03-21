Feature: Admins can manage riders
  Background:
    Given today is "2010-06-19"
    And a race exists for 2010

  Scenario: An Admin views all riders
    Given a solo team exists with name: "Bot and Rose Design"
    And a rider exists with name: "Micah Geisel", team: "Bot and Rose Design"
    And I am logged in as an admin
    When I follow "Races"
    And I follow "Edit" within the "Bot and Rose Design" team
    Then I should see "Micah Geisel"

  Scenario: An Admin edits all riders
    Given a team exists with name: "Bot and Rose Design"
    And I am logged in as an admin
    When I follow "Races"
    And I follow "Edit" within the "Bot and Rose Design" team
    
    When I fill in "Name" with "Paul Kjelland" within the first rider
    And I fill in "Email" with "paulkjell@gmail.com" within the first rider
    And I fill in "Phone" with "608.558.5276" within the first rider
    And I select "S" from "Shirt Size" within the first rider

    And I fill in "Address" with "300 Mayert Port" within the first rider
    And I fill in "Line 2" with "Apt A" within the first rider
    And I fill in "City" with "Milwaukee" within the first rider
    And I select "WI" from "State" within the first rider
    And I fill in "Zip" with "97209" within the first rider

    And I check "Paid?" within the first rider
    And I fill in "Payment Type" with "Cash" within the first rider
    And I select "August 1st, 2010" as the "Confirmed" date within the first rider

    And I fill in "Notes" with "Rider 1" within the first rider

    When I fill in "Name" with "Steve Whitlow" within the second rider
    And I fill in "Email" with "swirr2@gmail.com" within the second rider
    And I fill in "Phone" with "414.517.6870" within the second rider
    And I select "M" from "Shirt Size" within the second rider

    And I uncheck "Paid?" within the second rider
    And I fill in "Payment Type" with "Check" within the second rider
    And I select "August 2nd, 2010" as the "Confirmed" date within the second rider

    And I fill in "Notes" with "Rider 2" within the second rider

    And I press "Save"
    Then I should see "The team has been updated"
    And I should see the following leader:
      | Name          | Email               | Phone        | Shirt Size | Address         | Line 2 | City      | State | Zip   | Paid? | Payment Type | Confirmed | Notes   |
      | Paul Kjelland | paulkjell@gmail.com | 608.558.5276 | S          | 300 Mayert Port | Apt A  | Milwaukee | WI    | 97209 | Yes   | Cash         | 2010-8-1  | Rider 1 |
    And I should see the following riders:
      | Name           | Email                       | Phone                | Shirt Size | Paid? | Payment Type | Confirmed | Notes   |
      | Steve Whitlow  | swirr2@gmail.com            | 414.517.6870         | M          | No    | Check        | 2010-8-2  | Rider 2 |

  Scenario: An Admin creates a rider
    Given a team exists with name: "Bot and Rose Design"
    And I am logged in as an admin
    When I follow "Races"
    And I follow "Edit" within the "Bot and Rose Design" team
    And I follow "Add a rider"

    When I fill in "Name" with "Michael Gubitosa"
    And I fill in "Email" with "gubs@botandrose.com"
    And I fill in "Phone" with "267.664.0528"
    And I select "L" from "Shirt Size"

    And I check "Paid?"
    And I fill in "Payment Type" with "Cash"
    And I select "June 19th, 2010" as the "Confirmed" date

    And I fill in "Notes" with "this is a test"
    And I press "Save"

    When I follow "Races"
    And I follow "Edit" within the "Bot and Rose Design" team
    Then I should see "Michael Gubitosa"

  Scenario: An Admin edits a rider
    Given a solo team exists with name: "Bot and Rose Design"
    And a rider exists with name: "Micah Geisel", team: "Bot and Rose Design"
    And I am logged in as an admin
    When I follow "Races"
    And I follow "Edit" within the "Bot and Rose Design" team
    And I follow "Micah Geisel"

    When I fill in "Name" with "Michael Gubitosa"
    And I fill in "Email" with "gubs@botandrose.com"
    And I fill in "Phone" with "267.664.0528"
    And I select "L" from "Shirt Size"

    And I check "Paid?"
    And I fill in "Payment Type" with "Cash"
    And I select "June 19th, 2010" as the "Confirmed" date

    And I fill in "Notes" with "this is a test"
    And I press "Save"

    When I follow "Races"
    And I follow "Edit" within the "Bot and Rose Design" team
    Then I should see "Michael Gubitosa"

  Scenario: An admin deletes a rider
    Given a solo team exists with name: "Bot and Rose Design"
    And a rider exists with name: "Micah Geisel", team: "Bot and Rose Design"
    And I am logged in as an admin
    When I follow "Races"
    And I follow "Edit" within the "Bot and Rose Design" team
    And I follow "Delete Micah Geisel"

    When I follow "Races"
    And I follow "Edit" within the "Bot and Rose Design" team
    Then I should not see "Micah Geisel"
