Feature: Admins can manage race categories
  Background:
    Given today is "2025-06-19"
    And a race exists for 2024 with the following categories:
      | A Team        |
      | B Team        |
      | Solo (male)   |
      | Solo (female) |
      | Tandem        |
    And a race exists for 2025 with the following categories:
      | Solo (open)       |
      | Solo (M/T/NB)     |
      | Solo (F/T/NB)     |
      | Team              |
      | Tandem            |
      | Convoy            |
      | Elder             |
      | Perfect Strangers |
    And I am logged in as an admin
    When I follow "Races" within the admin nav
    And I follow "New Race"
    And I fill in the following form:
      | Year       | 2026                 |
      | Start time | July 25, 2026 7:00pm |
    And I press "Save"
    And I follow "Races" within the admin nav
    And I follow "Edit Race" within the "2026" race

  Scenario: New race has same categories as most recent race
    Then I should see the following categories:
      | NAME              | INITIAL | MIN | MAX |
      | Solo (open)       | S       | 1   | 1   |
      | Solo (M/T/NB)     | M       | 1   | 1   |
      | Solo (F/T/NB)     | F       | 1   | 1   |
      | Team              | B       | 2   | 6   |
      | Tandem            | T       | 2   | 2   |
      | Convoy            | C       | 2   | 6   |
      | Elder             | E       | 1   | 6   |
      | Perfect Strangers | P       | 2   | 6   |

  Scenario: Editing a category exclusive to this race mutates it in place
    When I follow "+ Add a Category"
    And I fill in the following form:
      | Name    | Contraption |
      | Initial | X           |
      | Min     | 1           |
      | Max     | 6           |
    And I press "Create Category"
    Then I should see "Category added!"

    When I follow "Edit" within the "Contraption" category
    And I fill in "Name" with "Contraption 2.0"
    And I press "Update Category"
    Then I should see "Category updated!"
    And I should see the following categories:
      | NAME              | INITIAL | MIN | MAX |
      | Solo (open)       | S       | 1   | 1   |
      | Solo (M/T/NB)     | M       | 1   | 1   |
      | Solo (F/T/NB)     | F       | 1   | 1   |
      | Team              | B       | 2   | 6   |
      | Tandem            | T       | 2   | 2   |
      | Convoy            | C       | 2   | 6   |
      | Elder             | E       | 1   | 6   |
      | Perfect Strangers | P       | 2   | 6   |
      | Contraption 2.0   | X       | 1   | 6   |

    When I follow "Races" within the admin nav
    And I follow "Edit Race" within the "2025" race
    Then I should see the following categories:
      | NAME              | INITIAL | MIN | MAX |
      | Solo (open)       | S       | 1   | 1   |
      | Solo (M/T/NB)     | M       | 1   | 1   |
      | Solo (F/T/NB)     | F       | 1   | 1   |
      | Team              | B       | 2   | 6   |
      | Tandem            | T       | 2   | 2   |
      | Convoy            | C       | 2   | 6   |
      | Elder             | E       | 1   | 6   |
      | Perfect Strangers | P       | 2   | 6   |

  Scenario: Editing a category shared with another race creates a new record
    When I follow "Edit" within the "Solo (open)" category
    And I fill in "Name" with "Solo (Non-Binary)"
    And I fill in "Initial" with "N"
    And I press "Update Category"
    Then I should see "Category updated!"
    And I should see the following categories:
      | NAME              | INITIAL | MIN | MAX |
      | Solo (Non-Binary) | N       | 1   | 1   |
      | Solo (M/T/NB)     | M       | 1   | 1   |
      | Solo (F/T/NB)     | F       | 1   | 1   |
      | Team              | B       | 2   | 6   |
      | Tandem            | T       | 2   | 2   |
      | Convoy            | C       | 2   | 6   |
      | Elder             | E       | 1   | 6   |
      | Perfect Strangers | P       | 2   | 6   |

    When I follow "Races" within the admin nav
    And I follow "Edit Race" within the "2025" race
    Then I should see the following categories:
      | NAME              | INITIAL | MIN | MAX |
      | Solo (open)       | S       | 1   | 1   |
      | Solo (M/T/NB)     | M       | 1   | 1   |
      | Solo (F/T/NB)     | F       | 1   | 1   |
      | Team              | B       | 2   | 6   |
      | Tandem            | T       | 2   | 2   |
      | Convoy            | C       | 2   | 6   |
      | Elder             | E       | 1   | 6   |
      | Perfect Strangers | P       | 2   | 6   |

  Scenario: Admin adds a new category
    When I follow "+ Add a Category"
    And I fill in the following form:
      | Name    | Contraption |
      | Initial | X           |
      | Min     | 1           |
      | Max     | 6           |
    And I press "Create Category"
    Then I should see "Category added!"
    And I should see the following categories:
      | NAME              | INITIAL | MIN | MAX |
      | Solo (open)       | S       | 1   | 1   |
      | Solo (M/T/NB)     | M       | 1   | 1   |
      | Solo (F/T/NB)     | F       | 1   | 1   |
      | Team              | B       | 2   | 6   |
      | Tandem            | T       | 2   | 2   |
      | Convoy            | C       | 2   | 6   |
      | Elder             | E       | 1   | 6   |
      | Perfect Strangers | P       | 2   | 6   |
      | Contraption       | X       | 1   | 6   |

    When I follow "Races" within the admin nav
    And I follow "Edit Race" within the "2025" race
    Then I should see the following categories:
      | NAME              | INITIAL | MIN | MAX |
      | Solo (open)       | S       | 1   | 1   |
      | Solo (M/T/NB)     | M       | 1   | 1   |
      | Solo (F/T/NB)     | F       | 1   | 1   |
      | Team              | B       | 2   | 6   |
      | Tandem            | T       | 2   | 2   |
      | Convoy            | C       | 2   | 6   |
      | Elder             | E       | 1   | 6   |
      | Perfect Strangers | P       | 2   | 6   |

  Scenario: Admin removes a category
    When I follow and confirm "Remove" within the "Perfect Strangers" category
    Then I should see "Category removed!"
    And I should see the following categories:
      | NAME          | INITIAL | MIN | MAX |
      | Solo (open)   | S       | 1   | 1   |
      | Solo (M/T/NB) | M       | 1   | 1   |
      | Solo (F/T/NB) | F       | 1   | 1   |
      | Team          | B       | 2   | 6   |
      | Tandem        | T       | 2   | 2   |
      | Convoy        | C       | 2   | 6   |
      | Elder         | E       | 1   | 6   |

    When I follow "Races" within the admin nav
    And I follow "Edit Race" within the "2025" race
    Then I should see the following categories:
      | NAME              | INITIAL | MIN | MAX |
      | Solo (open)       | S       | 1   | 1   |
      | Solo (M/T/NB)     | M       | 1   | 1   |
      | Solo (F/T/NB)     | F       | 1   | 1   |
      | Team              | B       | 2   | 6   |
      | Tandem            | T       | 2   | 2   |
      | Convoy            | C       | 2   | 6   |
      | Elder             | E       | 1   | 6   |
      | Perfect Strangers | P       | 2   | 6   |

  Scenario: Categories are locked when teams have been registered
    Given the following race teams exist:
      | Name | Class       | Leader Name | Leader Email          |
      | BARD | Solo (open) | Micah       | micah@riverwest24.com |
    When I follow "Races" within the admin nav
    And I follow "Edit Race" within the "2026" race
    Then I should see the following categories:
      | NAME              | INITIAL | MIN | MAX |
      | Solo (open)       | S       | 1   | 1   |
      | Solo (M/T/NB)     | M       | 1   | 1   |
      | Solo (F/T/NB)     | F       | 1   | 1   |
      | Team              | B       | 2   | 6   |
      | Tandem            | T       | 2   | 2   |
      | Convoy            | C       | 2   | 6   |
      | Elder             | E       | 1   | 6   |
      | Perfect Strangers | P       | 2   | 6   |
    And I should not see "+ Add a Category"
    And I should not see "Edit" within the "Solo (open)" category
    And I should not see "Remove" within the "Solo (open)" category
