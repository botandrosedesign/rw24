Feature: Admin can manage team scoring
  Background:
    Given today is "2020-07-25 19:00:00 CDT"
    And a race exists for 2020

    Given the following race teams exist:
      | POS# | Name | Class         | Leader Name | Leader Email          |
      | 001  | BARD | Solo (male)   | Micah       | micah@riverwest24.com |
      | 002  | BORG | Solo (female) | Julie       | julie@riverwest24.com |

    Given I am logged in as an admin
    And I am on the points page

    When I wait for 900 seconds
    And I fill in "Input Team Number:" with "1"
    And I press "OK" within the new lap form
    Then I should see the following laps:
      | POS#  | WHEN        | SINCE     | TYPE  | AMT | TOT | TEAM NAME |
      | 001   | 00:15:00    | 00:15:00  | Lap   | 1   | 1   | BARD      |

  Scenario: Existing laps
    Given I am on the leaderboard page
    Then I should see the following leaderboard:
      | POS# | CLASS | TEAM NAME | LAPS    | MILES      | BONUS | PENALTY | TOTAL |
      | 001  | M     | BARD      | 01      | 04         | --    | --      | 01    |
      | 002  | F     | BORG      | --      | --         | --    | --      | --    |
      |      |       |           | 1 LAPS! | 4.6 MILES! |       |         |       |

  Scenario: Admin can log a lap
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
    Then I should see the following leaderboard:
      | POS# | CLASS  | TEAM NAME | LAPS    | MILES       | BONUS | PENALTY | TOTAL |
      | 001  | M      | BARD      | 02      | 09          | --    | --      | 02    |
      | 002  | F      | BORG      | 01      | 04          | --    | --      | 01    |
      |      |        |           | 3 LAPS! | 13.8 MILES! |       |         |       |

  Scenario: Admin edits a lap
    When I wait for 900 seconds
    And I fill in "Input Team Number:" with "1"
    And I press "OK" within the new lap form
    Then I should see the following laps:
      | POS# | WHEN     | SINCE    | TYPE | AMT | TOT | TEAM NAME |
      | 001  | 00:30:00 | 00:15:00 | Lap  | 1   | 2   | BARD      |
      | 001  | 00:15:00 | 00:15:00 | Lap  | 1   | 1   | BARD      |

    Given I am on the leaderboard page
    When I follow "BARD"
    And I follow "Edit" within lap 1
    And I fill in "When" with "00:14:00"
    And I press "Update"
    And I follow "Back to Leader Board"

    Then I should see the following leaderboard:
      | POS# | CLASS | TEAM NAME | LAPS    | MILES      | BONUS | PENALTY | TOTAL |
      | 001  | M     | BARD      | 02      | 09         | --    | --      | 02    |
      | 002  | F     | BORG      | --      | --         | --    | --      | --    |
      |      |       |           | 2 LAPS! | 9.2 MILES! |       |         |       |

    Given I am on the points page
    Then I should see the following laps:
      | POS#  | WHEN        | SINCE     | TYPE  | AMT | TOT | TEAM NAME |
      | 001   | 00:30:00    | 00:16:00  | Lap   | 1   | 2   | BARD      |
      | 001   | 00:14:00    | 00:14:00  | Lap   | 1   | 2   | BARD      |

  Scenario: Admin removes a lap
    When I wait for 900 seconds
    And I fill in "Input Team Number:" with "1"
    And I press "OK" within the new lap form
    Then I should see the following laps:
      | POS# | WHEN     | SINCE    | TYPE | AMT | TOT | TEAM NAME |
      | 001  | 00:30:00 | 00:15:00 | Lap  | 1   | 2   | BARD      |
      | 001  | 00:15:00 | 00:15:00 | Lap  | 1   | 1   | BARD      |

    Given I am on the leaderboard page
    When I follow "BARD"
    And I follow and confirm "Delete" within lap 1
    And I follow "Back to Leader Board"
    Then I should see the following leaderboard:
      | POS# | CLASS | TEAM NAME | LAPS    | MILES      | BONUS | PENALTY | TOTAL |
      | 001  | M     | BARD      | 01      | 04         | --    | --      | 01    |
      | 002  | F     | BORG      | --      | --         | --    | --      | --    |
      |      |       |           | 1 LAPS! | 4.6 MILES! |       |         |       |

  Scenario: Admin splits a lap
    When I wait for 1800 seconds
    And I fill in "Input Team Number:" with "1"
    And I press "OK" within the new lap form
    Then I should see the following laps:
      | POS# | WHEN     | SINCE    | TYPE | AMT | TOT | TEAM NAME |
      | 001  | 00:45:00 | 00:30:00 | Lap  | 1   | 2   | BARD      |
      | 001  | 00:15:00 | 00:15:00 | Lap  | 1   | 1   | BARD      |

    Given I am on the leaderboard page
    When I follow "BARD"
    And I follow and confirm "Split" within lap 2
    Then I should see the following leaderboard:
      | POS# | CLASS | TEAM NAME | LAPS    | MILES       | BONUS | PENALTY | TOTAL |
      | 001  | M     | BARD      | 03      | 13          | --    | --      | 03    |
      | 002  | F     | BORG      | --      | --          | --    | --      | --    |
      |      |       |           | 3 LAPS! | 13.8 MILES! |       |         |       |

    Given I am on the points page
    Then I should see the following laps:
      | POS# | WHEN     | SINCE    | TYPE | AMT | TOT | TEAM NAME |
      | 001  | 00:45:00 | 00:15:00 | Lap  | 1   | 3   | BARD      |
      | 001  | 00:30:00 | 00:15:00 | Lap  | 1   | 3   | BARD      |
      | 001  | 00:15:00 | 00:15:00 | Lap  | 1   | 3   | BARD      |

  Scenario: Refuses an invalid lap but has opportunity to correct
    When I wait for 900 seconds
    And I fill in "Input Team Number:" with "10"
    And I press "OK" within the new lap form
    Then I should see the following laps:
      | POS# | WHEN     | SINCE    | TYPE | AMT | TOT       | TEAM NAME                   |
      | 010  |          |          | Lap  | 1   | Saving... | Team position doesn't exist |
      | 001  | 00:15:00 | 00:15:00 | Lap  | 1   | 1         | BARD                        |

    When I follow "Edit" within the first lap
    And I fill in "POS#" with "1" within the popup
    And I press "Update"
    Then I should see the following laps:
      | POS# | WHEN     | SINCE    | TYPE | AMT | TOT | TEAM NAME |
      | 001  | 00:30:00 | 00:15:00 | Lap  | 1   | 2   | BARD      |
      | 001  | 00:15:00 | 00:15:00 | Lap  | 1   | 1   | BARD      |

  Scenario: Bonus checkpoint folks can log bonus laps
    Given the race has the tattoo bonus checkpoint
    When I follow "Forms"
    Then I should see the following bonus checkpoints:
      | # | NAME   | POINTS |            |      |
      |   | Tattoo | 5      | Bonus Form | Edit |

    When I follow "Bonus Form"
    And I check "1"
    And I press "Save"
    Then I should see "Bonuses updated!"
    And I should see the following form:
      | 1 |

