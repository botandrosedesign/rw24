Feature: Admin exports database
  Scenario: Admin downloads a database dump
    Given a race exists for 2026
    And I am logged in as an admin
    When I follow "Current Race"
    And I press "Download Database"
    Then I should download a file named: "rw24-database-2026_03_26.sql"
