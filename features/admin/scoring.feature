Feature: Admin can manage team scoring
  Background:
    Given today is "2020-07-25 00:00:00 CDT"
    And a race exists for 2020

    Given the following race teams exist:
      | POS# | Name | Class         | Leader Name | Leader Email          |
      | 001  | BARD | Solo (male)   | Micah       | micah@riverwest24.com |
      | 002  | BORG | Solo (female) | Julie       | julie@riverwest24.com |

    Given I am logged in as an admin
    And I am on the points page

  Scenario: Existing laps
    Given I am on the leaderboard page
    Then I should see the following laps:
      | POS# | CLASS  | TEAM NAME | LAPS    | MILES      | BONUS | PENALTY | TOTAL |
      | 002  | F      | BORG      | --      | --         | --    | --      | --    |
      | 001  | M      | BARD      | --      | --         | --    | --      | --    |
      |      |        |           | 0 LAPS! | 0.0 MILES! |       |         |       |

  Scenario: Admin can log a lap
    When I wait for 900 seconds
    And I fill in "Input Team Number:" with "1"
    And I press "OK" within the new lap form
    Then I should see the following laps:
      | POS#  | WHEN        | SINCE     | TYPE  | AMT | TOT | TEAM NAME |
      | 001   | 00:15:00    | 00:15:00  | Lap   | 1   | 1   | BARD      |

    When I wait for 900 seconds
    And I fill in "Input Team Number:" with "1"
    And I press "OK" within the new lap form
    Then I should see the following laps:
      | POS#  | WHEN        | SINCE     | TYPE  | AMT | TOT | TEAM NAME |
      | 001   | 00:30:00    | 00:15:00  | Lap   | 1   | 2   | BARD      |
      | 001   | 00:15:00    | 00:15:00  | Lap   | 1   | 1   | BARD      |

    When I wait for 300 seconds
    And I fill in "Input Team Number:" with "2"
    And I press "OK" within the new lap form
    Then I should see the following laps:
      | POS#  | WHEN        | SINCE     | TYPE  | AMT | TOT | TEAM NAME |
      | 002   | 00:35:00    | 00:35:00  | Lap   | 1   | 1   | BORG      |
      | 001   | 00:30:00    | 00:15:00  | Lap   | 1   | 2   | BARD      |
      | 001   | 00:15:00    | 00:15:00  | Lap   | 1   | 1   | BARD      |


    Given I am on the leaderboard page
    Then I should see the following laps:
      | POS# | CLASS  | TEAM NAME | LAPS    | MILES       | BONUS | PENALTY | TOTAL |
      | 001  | M      | BARD      | 02      | 09          | --    | --      | 02    |
      | 002  | F      | BORG      | 01      | 04          | --    | --      | 01    |
      |      |        |           | 3 LAPS! | 13.8 MILES! |       |         |       |

  #Scenario: Admin removes a lap
    When I follow "BARD"
    And I follow "Delete" within lap 1
    #And I confirm deletion
    Given I am on the leaderboard page

    Then I should see the following laps:
      | POS# | CLASS  | TEAM NAME | LAPS    | MILES      | BONUS | PENALTY | TOTAL |
      | 002  | F      | BORG      | 01      | 04         | --    | --      | 01    |
      | 001  | M      | BARD      | 01      | 04         | --    | --      | 01    |
      |      |        |           | 2 LAPS! | 9.2 MILES! |       |         |       |

  #Scenario: Admin splits a lap
    When I follow "BARD"
    And I follow "Split" within lap 1
    Given I am on the points page

    Then I should see the following laps:
      | POS#  | WHEN        | SINCE     | TYPE  | AMT | TOT | TEAM NAME |
      | 001   | 00:15:00    | 00:15:00  | Lap   | 1   | 2   | BARD      |
      | 001   | 00:30:00    | 00:15:00  | Lap   | 1   | 2   | BARD      |
      | 002   | 00:35:00    | 00:35:00  | Lap   | 1   | 1   | BORG      |
