Feature: Admin can manage team bonuses
  Background:
    Given today is "2014-07-25"
    And a race exists for 2014

    Given the following race teams exist:
      | POS# | Name   | Class       |
      | 001  | BARD   | A Team      |
      | 002  | BORG   | A Team      |

    Given I am logged in as an admin
    And I follow "Races"
    And I follow "2014"
    And I follow "Settings"

  Scenario: Admin can add bonus checkpoints
    When I follow "+ Add a Checkpoint"
    And I fill in "Name" with "Example Bonus"
    And I fill in "Points" with "2"
    And I press "Create Bonus"
    Then I should see "Bonus added! Add another?"

  #Scenario: Log bonuses for teams
    When I follow "cancel"
    And I follow "Bonus Form" within "Example Bonus" checkpoint
    And I fill in "Team #" with "1"
    And I press "OK"
    Then I should see the following bonuses:
      | POS#  | WHEN | TYPE     | AMT | TOT | TEAM NAME |
      | 001   |      | Bonus 0  |  2  | 0   | BARD      |

    Given I am on the homepage
    When I follow "2014" within the "LEADERBOARDS" dropdown
    Then I should see the following laps:
      | POS# | CLASS  | TEAM NAME | LAPS | MILES | BONUS | PENALTY | TOTAL |
      | 001  | A      | BARD      | --   | --    | 2     | --      | 2     | 
      | 002  | A      | BORG      | --   | --    | --    | --      | --    | 
