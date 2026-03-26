Feature: Public leaderboard
  Background:
    Given today is "2026-07-25 19:00:00 CDT"
    And a race exists for 2026 with the following categories:
      | Solo (open) | Team |

    Given the following race teams exist:
      | POS# | Name        | Class       | Leader Name | Leader Email          | Rider 1 Email         |
      | 001  | Speed Demon | Solo (open) | Micah       | micah@riverwest24.com |                       |
      | 002  | Pedalers    | Team        | Julie       | julie@riverwest24.com | rider@riverwest24.com |

  Scenario: Visitor views the leaderboard
    Given I am on the leaderboard page
    Then I should see the following leaderboard:
      | POS# | CLASS | TEAM NAME   | LAPS    | MILES      | BONUS | PENALTY | TOTAL |
      | 002  | B     | Pedalers    | --      | --         | --    | --      | --    |
      | 001  | M     | Speed Demon | --      | --         | --    | --      | --    |
      |      |       |             | 0 LAPS! | 0.0 MILES! |       |         |       |

  Scenario: Visitor views a team's detail page
    Given I am logged in as an admin
    And I am on the points page

    When I wait for 900 seconds
    And I fill in "Input Team Number:" with "1"
    And I press "OK" within the new lap form

    When I go to the leaderboard page
    And I follow "Speed Demon"
    Then I should see "Speed Demon - Solo (open)"
    And I should see "1 lap"
    And I should see "4.6 miles"
