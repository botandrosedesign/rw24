Feature: Team Registration

  Scenario: A Team signs up with three members
    Given I am on the registration page
    When I fill in "Team Name" with "Bot and Rose Design"
    And I choose "A Team"

    And I fill in "Rider 1 Name" with "Micah Geisel"
    And I fill in "Rider 1 Email" with "micah@botandrose.com"
    And I fill in "Rider 2 Name" with "Michael Gubitosa"
    And I fill in "Rider 2 Email" with "gubs@botandrose.com"
    And I fill in "Rider 3 Name" with "Nick Hogle"
    And I fill in "Rider 3 Email" with "nick@botandrose.com"

    And I fill in "Address" with "625 NW Everett St"
    And I fill in "Line 2" with "#347"
    And I fill in "Phone" with "937.269.2023"

    And I select "2" from "Med"
    And I select "1" from "Lg"
    And I press "Continue to Payment"

    Then I should see "Please wait while we forward you to PayPal"
    And I should see a PayPal link to "riverwest24@gmail.com" for "Riverwest 24 Registration - A Team" at "$60.00"
