Feature: Admin can manage team bonuses
  Background:
    Given today is "2020-07-25 00:00:00 CDT"
    And a race exists for 2020

    Given the following race teams exist:
      | POS# | Name | Class         | Leader Name | Leader Email          |
      | 001  | BARD | Solo (male)   | Micah       | micah@riverwest24.com |
      | 002  | BORG | Solo (female) | Julie       | julie@riverwest24.com |

    Given I am logged in as an admin
    When I follow "Races"
    And I follow "2020"
    And I follow "Settings" within the admin subnav

  Scenario: Admin can add bonus checkpoints
    When I follow "+ Add a Checkpoint"
    And I fill in "Name" with "Example Bonus"
    And I fill in "Points" with "2"
    And I press "Create Bonus"
    Then I should see "Bonus added! Add another?"
    
    When I fill in "Name" with "Another Bonus"
    And I fill in "Points" with "2"
    And I press "Create Bonus"
    Then I should see "Bonus added! Add another?"

  #Scenario: Log bonuses for teams
    When I follow "cancel"
    And I follow "Bonus Form" within the "Example Bonus" checkpoint
    And I fill in "Team #" with "1"
    And I press "OK"
    Then I should see the following laps:
      | POS#  | WHEN     | SINCE    | TYPE     | AMT | TOT | TEAM NAME |
      | 001   | 00:00:00 | 00:00:00 | Bonus 0  |  2  | 0   | BARD      |

    Given I am on the leaderboard page
    Then I should see the following laps:
      | POS# | CLASS  | TEAM NAME | LAPS    | MILES      | BONUS | PENALTY | TOTAL |
      | 001  | M      | BARD      | --      | --         | 02    | --      | 02    |
      | 002  | F      | BORG      | --      | --         | --    | --      | --    |
      |      |        |           | 0 LAPS! | 0.0 MILES! |       |         |       |

    When I follow "BARD"
    Then I should see the following bonuses:
      | BONUSES               |
      | ✓ 0 - Example Bonus   |
      | - 1 - Another Bonus   |

  #Scenario: Admin can delete a bonus lap
    When I follow "Delete Score" within the "0 - Example Bonus" checkpoint
    #And I confirm deletion
    Then I should see the following bonuses:
      | BONUSES               |
      | - 0 - Example Bonus   |
      | - 1 - Another Bonus   |

