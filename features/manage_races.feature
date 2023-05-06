Feature: Admins can manage races
  Background:
    Given today is "2010-06-19"
    And a race exists for 2010
    And I am logged in as an admin
    When I follow "Races"

  Scenario: Admin is redirected to create a race if none exist
    Given there are no races
    When I follow "Races" within the admin nav
    And I fill in "Year" with "2011"

  Scenario: Admin sees all races
    Then I should see the following races:
      | YEAR |
      | 2010 |

  Scenario: Admin creates a new race
    When I follow "New Race"
    And I fill in "Year" with "2011"
    And I select "July 31, 2011 7:00pm" as the "Start time" date and time
    And I check "Show race in leaderboards dropdown menu?"
    And I fill in "Description" with "Biggest race yet!"
    And I press "Save"
    Then I should see "Race created!"

    When I follow "Races" within the admin nav
    Then I should see the following races:
      | YEAR |
      | 2011 |
      | 2010 |

  Scenario: Admin updates an existing race
    When I follow "Edit Race"
    And I fill in "Year" with "2011"
    And I select "July 31, 2011 7:00pm" as the "Start time" date and time
    And I check "Show race in leaderboards dropdown menu?"
    And I fill in "Description" with "Biggest race yet!"
    And I press "Save"
    Then I should see "Race updated!"

    When I follow "Races" within the admin nav
    Then I should see the following races:
      | YEAR |
      | 2011 |

