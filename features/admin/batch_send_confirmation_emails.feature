Feature: Admins can batch send confirmation emails to teams

  @wip
  Scenario: Admin sends an email to some recipients
    Given the following race teams exist:
      | Name                | Class       | Leader Name  | Leader Email             | Rider 1 Email        | Rider 2 Email       |
      | Bot and Rose Design | A Team      | Micah Geisel | info@botandrose.com      | micah@botandrose.com | gubs@botandrose.com |
      | Bog and Rat Defeat  | B Team      | Hacim Leseig | info@bogandrat.com       | micah@bogandrat.com  | gubs@bogandrat.com  |
      | Micah               | Solo (male) | Micah Diesel | originofstorms@gmail.com | | |
    And I am logged in as an Admin

    When I follow "Races"
    Then I should see the following teams:
      | Paid | Emailed | POS# | Class | Team Name           | Riders | Leader Name  |
      | No   | No      | 1    | A     | Bot and Rose Design | 3      | Micah Geisel |
      | No   | No      | 2    | B     | Bog and Rat Defeat  | 3      | Hacim Leseig |
      | No   | No      | 3    | S     | Micah               | 1      | Micah Diesel |
    
    When I check "Bot and Rose Design"
    And I check "Micah"
    And I press "Send Confirmation Email"
    # Then I should see "Confirmation emails sending!"
    Then I should see the following teams:
      | Paid | Emailed | POS# | Class | Team Name           | Riders | Leader Name  |
      | No   | Yes     | 1    | A     | Bot and Rose Design | 3      | Micah Geisel |
      | No   | No      | 2    | B     | Bog and Rat Defeat  | 3      | Hacim Leseig |
      | No   | Yes     | 3    | S     | Micah               | 1      | Micah Diesel |

    And "info@botandrose.com" should receive an email
    And "micah@botandrose.com" should receive an email
    And "gubs@botandrose.com" should receive an email

    And "info@bogandrat.com" should receive no emails
    And "micah@bogandrat.com" should receive no emails
    And "gubs@bogandrat.com" should receive no emails

    And "originofstorms@gmail.com" should receive an email

    When "info@botandrose.com" opens the email with subject "Riverwest 24 2012: 1 - Bot and Rose Design"
    Then they should see the following in the email body:
      """
      Team name: Bot and Rose Design
      Position: 1
      Class: A Team
      Shirt sizes: M, M, M

      ---

      Thank you for registering for RW24 2012! Let us know if there are any
      changes you need to your information above, especially shirt sizes. We need
      confirmation QUICKLY on what shirt sizes you need. We will be placing our
      orders for shirts shortly. Let us know quickly or we cannot guarantee size.
      But we promise to have a shirt for you.
      """
