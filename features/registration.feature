Feature: Team Registration

  Scenario: A Team signs up with three members
    Given I am on the registration page
    When I fill in "Team Name" with "Bot and Rose Design"
    And I choose "A Team"

    And I fill in "Rider 1 Name" with "Micah Geisel"
    And I fill in "Rider 1 Email" with "micah@botandrose.com"
    And I fill in "Rider 1 Shirt" with "S"
    And I fill in "Rider 2 Name" with "Michael Gubitosa"
    And I fill in "Rider 2 Email" with "gubs@botandrose.com"
    And I fill in "Rider 2 Shirt" with "L"
    And I fill in "Rider 3 Name" with "Nick Hogle"
    And I fill in "Rider 3 Email" with "nick@botandrose.com"
    And I fill in "Rider 3 Shirt" with "M"

    And I fill in "Address" with "625 NW Everett St"
    And I fill in "Line 2" with "#347"
    And I fill in "City" with "Portland"
    And I select "OR" from "State"
    And I fill in "Zip" with "97209"
    And I fill in "Phone" with "937.269.2023"

    And I press "Continue to Payment"

    Then I should see "Please wait while we forward you to PayPal"
    # And I should see a PayPal form for "Riverwest 24 Registration - A Team" at "$60.00"
    And "micah@botandrose.com" should receive an email
    And "gubs@botandrose.com" should receive an email
    And "nick@botandrose.com" should receive an email

    When they open the email
    Then they should see the email delivered from "register@riverwest24.com"
    Then they should see "Riverwest 24 2010 - Team signup confirmation" in the email subject
    And they should see "Micah Geisel" in the email body
    And they should see "Michael Gubitosa" in the email body
    And they should see "Nick Hogle" in the email body
    And they should see /Position: \d+/ in the email body
    And they should see "Class: A Team" in the email body
    And they should see "Team: Bot and Rose Design" in the email body

  Scenario: B Team signs up with 2 members
    Given I am on the registration page
    When I fill in "Team Name" with "Bot and Rose Design"
    And I choose "B Team"

    And I fill in "Rider 1 Name" with "Micah Geisel"
    And I fill in "Rider 1 Email" with "micah@botandrose.com"
    And I fill in "Rider 1 Shirt" with "S"
    And I fill in "Rider 2 Name" with "Michael Gubitosa"
    And I fill in "Rider 2 Email" with "gubs@botandrose.com"
    And I fill in "Rider 2 Shirt" with "L"

    And I fill in "Address" with "625 NW Everett St"
    And I fill in "Line 2" with "#347"
    And I fill in "City" with "Portland"
    And I select "OR" from "State"
    And I fill in "Zip" with "97209"
    And I fill in "Phone" with "937.269.2023"

    And I press "Continue to Payment"

    Then I should see "Please wait while we forward you to PayPal"
    And I should see a PayPal form for "Riverwest 24 Registration - B Team" at "$40.00"
    And "micah@botandrose.com" should receive an email
    And "gubs@botandrose.com" should receive an email

    When they open the email
    Then they should see the email delivered from "register@riverwest24.com"
    Then they should see "Riverwest 24 2010 - Team signup confirmation" in the email subject
    And they should see "Micah Geisel" in the email body
    And they should see "Michael Gubitosa" in the email body
    And they should see /Position: \d+/ in the email body
    And they should see "Class: B Team" in the email body
    And they should see "Team: Bot and Rose Design" in the email body

  Scenario: Solo (male) signs up with one member
    Given I am on the registration page
    When I fill in "Team Name" with "Bot and Rose Design"
    And I choose "Solo (male)"

    And I fill in "Rider 1 Name" with "Micah Geisel"
    And I fill in "Rider 1 Email" with "micah@botandrose.com"
    And I fill in "Rider 1 Shirt" with "S"

    And I fill in "Address" with "625 NW Everett St"
    And I fill in "Line 2" with "#347"
    And I fill in "City" with "Portland"
    And I select "OR" from "State"
    And I fill in "Zip" with "97209"
    And I fill in "Phone" with "937.269.2023"

    And I press "Continue to Payment"

    Then I should see "Please wait while we forward you to PayPal"
    And I should see a PayPal form for "Riverwest 24 Registration - Solo (male)" at "$20.00"
    And "micah@botandrose.com" should receive an email

    When they open the email
    Then they should see the email delivered from "register@riverwest24.com"
    Then they should see "Riverwest 24 2010 - Team signup confirmation" in the email subject
    And they should see "Micah Geisel" in the email body
    And they should see /Position: \d+/ in the email body
    And they should see "Class: Solo (male)" in the email body
    And they should see "Team: Bot and Rose Design" in the email body

  Scenario: Solo (female) signs up with one member
    Given I am on the registration page
    When I fill in "Team Name" with "Bot and Rose Design"
    And I choose "Solo (female)"

    And I fill in "Rider 1 Name" with "Micah Geisel"
    And I fill in "Rider 1 Email" with "micah@botandrose.com"
    And I fill in "Rider 1 Shirt" with "S"

    And I fill in "Address" with "625 NW Everett St"
    And I fill in "Line 2" with "#347"
    And I fill in "City" with "Portland"
    And I select "OR" from "State"
    And I fill in "Zip" with "97209"
    And I fill in "Phone" with "937.269.2023"

    And I press "Continue to Payment"

    Then I should see "Please wait while we forward you to PayPal"
    And I should see a PayPal form for "Riverwest 24 Registration - Solo (female)" at "$20.00"
    And "micah@botandrose.com" should receive an email

    When they open the email
    Then they should see the email delivered from "register@riverwest24.com"
    Then they should see "Riverwest 24 2010 - Team signup confirmation" in the email subject
    And they should see "Micah Geisel" in the email body
    And they should see /Position: \d+/ in the email body
    And they should see "Class: Solo (female)" in the email body
    And they should see "Team: Bot and Rose Design" in the email body

  Scenario: Tandem signs up with two members
    Given I am on the registration page
    When I fill in "Team Name" with "Bot and Rose Design"
    And I choose "Tandem"

    And I fill in "Rider 1 Name" with "Micah Geisel"
    And I fill in "Rider 1 Email" with "micah@botandrose.com"
    And I fill in "Rider 1 Shirt" with "S"
    And I fill in "Rider 2 Name" with "Michael Gubitosa"
    And I fill in "Rider 2 Email" with "gubs@botandrose.com"
    And I fill in "Rider 2 Shirt" with "L"

    And I fill in "Address" with "625 NW Everett St"
    And I fill in "Line 2" with "#347"
    And I fill in "City" with "Portland"
    And I select "OR" from "State"
    And I fill in "Zip" with "97209"
    And I fill in "Phone" with "937.269.2023"

    And I press "Continue to Payment"

    Then I should see "Please wait while we forward you to PayPal"
    And I should see a PayPal form for "Riverwest 24 Registration - Tandem" at "$40.00"
    And "micah@botandrose.com" should receive an email
    And "gubs@botandrose.com" should receive an email

    When they open the email
    Then they should see the email delivered from "register@riverwest24.com"
    Then they should see "Riverwest 24 2010 - Team signup confirmation" in the email subject
    And they should see "Micah Geisel" in the email body
    And they should see "Michael Gubitosa" in the email body
    And they should see /Position: \d+/ in the email body
    And they should see "Class: Tandem" in the email body
    And they should see "Team: Bot and Rose Design" in the email body
