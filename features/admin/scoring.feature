Feature: Admin can manage team scoring
  Background:
    Given today is "2014-07-25"
    And a race exists for 2014

    Given the following race teams exist:
      | POS# | Name   | Class       |
      | 001  | BARD   | A Team      |
      | 002  | BORG   | A Team      |

    Given I am logged in as an admin
    And I am on the points page

  Scenario: Existing laps
    Given I am on the homepage
    When I follow "2014" within the "LEADERBOARDS" dropdown
    Then I should see the following laps:
      | POS# | CLASS  | TEAM NAME | LAPS | MILES | BONUS | PENALTY | TOTAL |
      | 002  | A      | BORG      | --   | --    | --    | --      | --    | 
      | 001  | A      | BARD      | --   | --    | --    | --      | --    | 

  Scenario: Admin can log a lap
    When I fill in "Input Team Number:" with "1"
    And I press "OK"

    Then I should see the following laps:
      | POS#  | WHEN        | TYPE  | AMT | TOT | TEAM NAME           |
      | 001   |             | Lap   | 1   | 1   | Bot and Rose Design |

    Given I am on the homepage
    When I follow "2014" within the "LEADERBOARDS" dropdown
    Then I should see the following laps:
      | POS# | CLASS  | TEAM NAME | LAPS | MILES | BONUS | PENALTY | TOTAL |
      | 001  | A      | BARD      | 01   | 4.5   | --    | --      | 01    | 
      | 002  | A      | BORG      | --   | --    | --    | --      | --    | 

  #Scenario: Admin remove laps
    When I follow "BARD" within the leaderboard
    And I follow "Delete" with the "1" lap
    #And I confirm deletion
    And I follow "« Back to Leader Board"

    Then I should see the following laps:
      | POS# | CLASS  | TEAM NAME | LAPS | MILES | BONUS | PENALTY | TOTAL |
      | 002  | A      | BORG      | --   | --    | --    | --      | --    | 
      | 001  | A      | BARD      | --   | --    | --    | --      | --    | 
