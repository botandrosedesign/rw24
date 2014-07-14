Feature: Admin can manage team scoring
  Background:
    Given today is "2014-07-25"
    And a race exists for 2014

    Given the following race teams exist:
      | POS# | Name | Class         |
      | 001  | BARD | Solo (male)   |
      | 002  | BORG | Solo (female) |

    Given I am logged in as an Admin
    And I am on the points page

  Scenario: Existing laps
    Given I am on the leaderboard page
    Then I should see the following laps:
      | POS# | CLASS  | TEAM NAME | LAPS  | MILES  | BONUS | PENALTY | TOTAL |
      | 002  | F      | BORG      | --    | --     | --    | --      | --    | 
      | 001  | M      | BARD      | --    | --     | --    | --      | --    | 
      |      |        |           | LAPS! | MILES! |       |         |       |

  Scenario: Admin can log a lap
    When I fill in "Input Team Number:" with "1"
    And I press "OK" within the new lap form
    Then I should see the following laps:
      | POS#  | WHEN        | TYPE  | AMT | TOT | TEAM NAME |
      | 001   | 00:00:00    | Lap   | 1   | 1   | BARD      |

    Given I am on the leaderboard page
    Then I should see the following laps:
      | POS# | CLASS  | TEAM NAME | LAPS  | MILES  | BONUS | PENALTY | TOTAL |
      | 001  | M      | BARD      | 01    | 04     | --    | --      | 01    | 
      | 002  | F      | BORG      | --    | --     | --    | --      | --    | 
      |      |        |           | LAPS! | MILES! |       |         |       |

  #Scenario: Admin remove laps
    When I follow "BARD"
    And I follow "Delete" within lap 1
    #And I confirm deletion
    Given I am on the leaderboard page

    Then I should see the following laps:
      | POS# | CLASS  | TEAM NAME | LAPS  | MILES  | BONUS | PENALTY | TOTAL |
      | 002  | F      | BORG      | --    | --     | --    | --      | --    | 
      | 001  | M      | BARD      | --    | --     | --    | --      | --    | 
      |      |        |           | LAPS! | MILES! |       |         |       |

