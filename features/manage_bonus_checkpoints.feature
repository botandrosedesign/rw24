Feature: Admin can manage team bonuses
  Background:
    Given today is "2020-07-25 19:00:00 CDT"
    And a race exists for 2020 with the following bonus checkpoints:
      | # | Name         | Points |
      | 0 | Tattoo       | 5      |
      | 1 | First Bonus  | 1      |
      | 2 | Second Bonus | 10     |
      | 3 | Third Bonus  | 24     |
      | 4 | All Bonuses! | 5      |

    Given the following race teams exist:
      | POS# | Name | Class         | Leader Name | Leader Email          |
      | 001  | BARD | Solo (male)   | Micah       | micah@riverwest24.com |
      | 002  | BORG | Solo (female) | Julie       | julie@riverwest24.com |

    Given I am logged in as an admin
    When I follow "Races"
    And I follow "Edit Race" within the "2020" race

  Scenario: Admin can see a list of bonus checkpoints
    Then I should see the following bonus checkpoints:
      | # | NAME         | POINTS |
      |   | Tattoo       | 5      |
      |   | First Bonus  | 1      |
      |   | Second Bonus | 10     |
      |   | Third Bonus  | 24     |
      |   | All Bonuses! | 5      |

# FIXME: Can Chrome test HTML5 drag-and-drop yet? https://bugs.chromium.org/p/chromium/issues/detail?id=850071
# Scenario: Admin can reorder bonus checkpoints
#   When I drag the "Third Bonus" bonus above the "First Bonus" bonus
#   Then I should see the following bonus checkpoints:
#     | # | NAME         | POINTS |
#     |   | Tattoo       | 5      |
#     |   | Third Bonus  | 24     |
#     |   | First Bonus  | 1      |
#     |   | Second Bonus | 10     |
#     |   | All Bonuses! | 5      |

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

    When I follow "cancel"
    Then I should see the following bonus checkpoints:
      | # | NAME          | POINTS |
      |   | Tattoo        | 5      |
      |   | First Bonus   | 1      |
      |   | Second Bonus  | 10     |
      |   | Third Bonus   | 24     |
      |   | All Bonuses!  | 5      |
      |   | Example Bonus | 2      |
      |   | Another Bonus | 2      |

  Scenario: Admin can edit a bonus checkpoint
    When I follow "Edit" within the "First Bonus" checkpoint
    And I fill in "Name" with "Primary Bonus"
    And I fill in "Points" with "5"
    And I press "Update Bonus"
    Then I should see "Bonus updated!"

    Then I should see the following bonus checkpoints:
      | # | NAME          | POINTS |
      |   | Tattoo        | 5      |
      |   | Primary Bonus | 5      |
      |   | Second Bonus  | 10     |
      |   | Third Bonus   | 24     |
      |   | All Bonuses!  | 5      |

  Scenario: Log bonuses for teams
    When I follow "Bonus Form" within the "First Bonus" checkpoint
    And I check "1"
    And I press "Save"
    Then I should see "Bonuses updated!"
    And I should see the following form:
      | 1 |

    Given I am on the admin overview page
    When I follow "Races"
    And I follow "Edit Race" within the "2020" race
    And I follow "First Bonus"
    Then I should see "BONUS #1 - FIRST BONUS"
    And I should see the following team bonuses:
      | POS# | TEAM NAME | POINTS |
      | 1    | BARD      | 1      |

    Given I am on the leaderboard page
    Then I should see the following leaderboard:
      | POS# | CLASS  | TEAM NAME | LAPS    | MILES      | BONUS | PENALTY | TOTAL |
      | 001  | M      | BARD      | --      | --         | 01    | --      | 01    |
      | 002  | F      | BORG      | --      | --         | --    | --      | --    |
      |      |        |           | 0 LAPS! | 0.0 MILES! |       |         |       |

    When I follow "BARD"
    Then I should see the following bonuses:
      | BONUSES               |
      | - 0 - Tattoo 5        |
      | ✓ 1 - First Bonus 1   |
      | - 2 - Second Bonus 10 |
      | - 3 - Third Bonus 24  |
      | - 4 - All Bonuses! 5  |

# Scenario: Admin can delete a bonus lap
#   When I follow and confirm "Delete Score" within the "0 - Example Bonus" checkpoint
#   Then I should see the following bonuses:
#     | BONUSES                 |
#     | - 0 - Example Bonus     |
#     | - 1 - Yet Another Bonus |

  Scenario: Admin can delete all bonuses
    When I press and confirm "Delete All Bonuses"
    Then I should see "All Bonuses deleted!"
    And I should see the following bonus checkpoints:
      | # | NAME | POINTS |

  Scenario: Getting all bonuses except Tattoo awards All Bonuses! bonus
    When I follow "Bonus Form" within the "First Bonus" checkpoint
    And I check "1"
    And I press "Save"
    Then I should see "Bonuses updated!"

    Given I am on the admin overview page
    When I follow "Races"
    And I follow "Edit Race" within the "2020" race

    When I follow "Bonus Form" within the "Second Bonus" checkpoint
    And I check "1"
    And I press "Save"
    Then I should see "Bonuses updated!"

    Given I am on the leaderboard page
    Then I should see the following leaderboard:
      | POS# | CLASS  | TEAM NAME | LAPS    | MILES      | BONUS | PENALTY | TOTAL |
      | 001  | M      | BARD      | --      | --         | 11    | --      | 11    |
      | 002  | F      | BORG      | --      | --         | --    | --      | --    |
      |      |        |           | 0 LAPS! | 0.0 MILES! |       |         |       |

    When I follow "BARD"
    Then I should see the following bonuses:
      | BONUSES                |        |
      | - 0 - Tattoo 5         |        |
      | ✓ 1 - First Bonus 1    | Delete |
      | ✓ 2 - Second Bonus 10  | Delete |
      | - 3 - Third Bonus 24   |        |
      | - 4 - All Bonuses! 5   |        |

    Given I am on the admin overview page
    When I follow "Races"
    And I follow "Edit Race" within the "2020" race

    When I follow "Bonus Form" within the "Third Bonus" checkpoint
    And I check "1"
    And I press "Save"
    Then I should see "Bonuses updated!"

    Given I am on the points page
    When I press and confirm "Assign All Bonuses Bonus"
    Then I should see "All Bonuses Bonus assigned!"

    Given I am on the leaderboard page
    Then I should see the following leaderboard:
      | POS# | CLASS  | TEAM NAME | LAPS    | MILES      | BONUS | PENALTY | TOTAL |
      | 001  | M      | BARD      | --      | --         | 40    | --      | 40    |
      | 002  | F      | BORG      | --      | --         | --    | --      | --    |
      |      |        |           | 0 LAPS! | 0.0 MILES! |       |         |       |

    When I follow "BARD"
    Then I should see the following bonuses:
      | BONUSES                |        |
      | - 0 - Tattoo 5         |        |
      | ✓ 1 - First Bonus 1    | Delete |
      | ✓ 2 - Second Bonus 10  | Delete |
      | ✓ 3 - Third Bonus 24   | Delete |
      | ✓ 4 - All Bonuses! 5   | Delete |

  Scenario: Getting all bonuses WITH Tattoo does not award All Bonuses! bonus
    Given I am on the points page
    When I fill in "POS#" with "1" within the bonus form
    And I fill in "Bonus#" with "0" within the bonus form
    And I press "OK" within the bonus form

    When I fill in "POS#" with "1" within the bonus form
    And I fill in "Bonus#" with "1" within the bonus form
    And I press "OK" within the bonus form

    When I fill in "POS#" with "1" within the bonus form
    And I fill in "Bonus#" with "2" within the bonus form
    And I press "OK" within the bonus form

    When I fill in "POS#" with "1" within the bonus form
    And I fill in "Bonus#" with "3" within the bonus form
    And I press "OK" within the bonus form

    When I press and confirm "Assign All Bonuses Bonus"

    Given I am on the leaderboard page
    Then I should see the following leaderboard:
      | POS# | CLASS  | TEAM NAME | LAPS    | MILES      | BONUS | PENALTY | TOTAL |
      | 001  | M      | BARD      | --      | --         | 40    | --      | 40    |
      | 002  | F      | BORG      | --      | --         | --    | --      | --    |
      |      |        |           | 0 LAPS! | 0.0 MILES! |       |         |       |

    When I follow "BARD"
    Then I should see the following bonuses:
      | BONUSES                |        |
      | ✓ 0 - Tattoo 5         | Delete |
      | ✓ 1 - First Bonus 1    | Delete |
      | ✓ 2 - Second Bonus 10  | Delete |
      | ✓ 3 - Third Bonus 24   | Delete |
      | - 4 - All Bonuses! 5   |        |

