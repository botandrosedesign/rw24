Feature: Admin can manage team bonuses
  Background:
    Given today is "2020-07-25 19:00:00 CDT"
    And a race exists for 2020

    Given the following race teams exist:
      | POS# | Name | Class         | Leader Name | Leader Email          |
      | 001  | BARD | Solo (male)   | Micah       | micah@riverwest24.com |
      | 002  | BORG | Solo (female) | Julie       | julie@riverwest24.com |

    Given I am logged in as an admin
    When I follow "Races"
    And I follow "2020"
    And I follow "Edit Race" within the admin subnav

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

  #Scenario: Admin can edit a bonus checkpoint
    When I follow "cancel"
    And I follow "Edit" within the "Another Bonus" checkpoint
    And I fill in "Name" with "Yet Another Bonus"
    And I fill in "Points" with "5"
    And I press "Update Bonus"
    Then I should see "Bonus updated!"

  #Scenario: Admin can see a list of bonus checkpoints
    And I should see the following bonus checkpoints:
      | # | NAME              | POINTS |
      | 0 | Example Bonus     | 2      |
      | 1 | Yet Another Bonus | 5      |

  #Scenario: Log bonuses for teams
    When I follow "Bonus Form" within the "Example Bonus" checkpoint
    And I check "1"
    And I press "Save"
    # Then I should see "BONUSES UPDATED!" # FIXME flash doesnt work on frontend
    And I should see the following form:
      | 1 |

    Given I am on the admin overview page
    When I follow "Races"
    And I follow "2020"
    And I follow "Edit Race" within the admin subnav
    And I follow "Example Bonus"
    Then I should see "BONUS #0 - EXAMPLE BONUS"
    And I should see the following team bonuses:
      | 1 | BARD | 2 |

    Given I am on the leaderboard page
    Then I should see the following leaderboard:
      | POS# | CLASS  | TEAM NAME | LAPS    | MILES      | BONUS | PENALTY | TOTAL |
      | 001  | M      | BARD      | --      | --         | 02    | --      | 02    |
      | 002  | F      | BORG      | --      | --         | --    | --      | --    |
      |      |        |           | 0 LAPS! | 0.0 MILES! |       |         |       |

    When I follow "BARD"
    Then I should see the following bonuses:
      | BONUSES                 |
      | ✓ 0 - Example Bonus     |
      | - 1 - Yet Another Bonus |

  #Scenario: Admin can delete a bonus lap
    When I follow and confirm "Delete Score" within the "0 - Example Bonus" checkpoint
    Then I should see the following bonuses:
      | BONUSES                 |
      | - 0 - Example Bonus     |
      | - 1 - Yet Another Bonus |

  #Scenario: Admin can delete all bonuses
    Given I am on the admin overview page
    When I follow "Races"
    And I follow "2020"
    And I follow "Edit Race" within the admin subnav
    And I press and confirm "Delete All Bonuses"
    Then I should see "All Bonuses deleted!"
    And I should see the following bonus checkpoints:
      | # | NAME              | POINTS |

  Scenario: Getting all bonuses except Tattoo awards All Bonuses! bonus
    When I follow "+ Add a Checkpoint"
    And I fill in "Name" with "Tattoo"
    And I fill in "Points" with "5"
    And I press "Create Bonus"

    When I fill in "Name" with "First Bonus"
    And I fill in "Points" with "1"
    And I press "Create Bonus"

    When I fill in "Name" with "Second Bonus"
    And I fill in "Points" with "10"
    And I press "Create Bonus"

    When I fill in "Name" with "Third Bonus"
    And I fill in "Points" with "24"
    And I press "Create Bonus"

    When I fill in "Name" with "All Bonuses!"
    And I fill in "Points" with "5"
    And I press "Create Bonus"

    When I follow "cancel"
    Then I should see the following bonus checkpoints:
      | # | NAME              | POINTS |
      | 0 | Tattoo            | 5      |
      | 1 | First Bonus       | 1      |
      | 2 | Second Bonus      | 10     |
      | 3 | Third Bonus       | 24     |
      | 4 | All Bonuses!      | 5      |

    When I follow "Bonus Form" within the "First Bonus" checkpoint
    And I check "1"
    And I press "Save"

    Given I am on the admin overview page
    When I follow "Races"
    And I follow "2020"
    And I follow "Edit Race" within the admin subnav

    When I follow "Bonus Form" within the "Second Bonus" checkpoint
    And I check "1"
    And I press "Save"

    Given I am on the leaderboard page
    Then I should see the following leaderboard:
      | POS# | CLASS  | TEAM NAME | LAPS    | MILES      | BONUS | PENALTY | TOTAL |
      | 001  | M      | BARD      | --      | --         | 11    | --      | 11    |
      | 002  | F      | BORG      | --      | --         | --    | --      | --    |
      |      |        |           | 0 LAPS! | 0.0 MILES! |       |         |       |

    When I follow "BARD"
    Then I should see the following bonuses:
      | 0 - Tattoo        |           |
      | 1 - First bonus   | Delete    |
      | 2 - Second bonus  | Delete    |
      | 3 - Third bonus   |           |
      | 4 - All bonuses   |           |

    Given I am on the admin overview page
    When I follow "Races"
    And I follow "2020"
    And I follow "Edit Race" within the admin subnav

    When I follow "Bonus Form" within the "Third Bonus" checkpoint
    And I check "1"
    And I press "Save"

    Given I am on the leaderboard page
    Then I should see the following leaderboard:
      | POS# | CLASS  | TEAM NAME | LAPS    | MILES      | BONUS | PENALTY | TOTAL |
      | 001  | M      | BARD      | --      | --         | 40    | --      | 40    |
      | 002  | F      | BORG      | --      | --         | --    | --      | --    |
      |      |        |           | 0 LAPS! | 0.0 MILES! |       |         |       |

    When I follow "BARD"
    Then I should see the following bonuses:
      | 0 - Tattoo        |           |
      | 1 - First bonus   | Delete    |
      | 2 - Second bonus  | Delete    |
      | 3 - Third bonus   | Delete    |
      | 4 - All bonuses   | Delete    |

  # Scenario: Getting all bonuses WITH Tattoo does not award All Bonuses! bonus
    Given I am on the admin overview page
    When I follow "Races"
    And I follow "2020"
    And I follow "Edit Race" within the admin subnav

    When I follow "Bonus Form" within the "Tattoo" checkpoint
    And I check "1"
    And I press "Save"

    Given I am on the leaderboard page
    Then I should see the following leaderboard:
      | POS# | CLASS  | TEAM NAME | LAPS    | MILES      | BONUS | PENALTY | TOTAL |
      | 001  | M      | BARD      | --      | --         | 40    | --      | 40    |
      | 002  | F      | BORG      | --      | --         | --    | --      | --    |
      |      |        |           | 0 LAPS! | 0.0 MILES! |       |         |       |

    When I follow "BARD"
    Then I should see the following bonuses:
      | 0 - Tattoo        | Delete    |
      | 1 - First bonus   | Delete    |
      | 2 - Second bonus  | Delete    |
      | 3 - Third bonus   | Delete    |
      | 4 - All bonuses   |           |
