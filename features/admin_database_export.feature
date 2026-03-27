Feature: Admin exports database
  Scenario: Admin downloads a database dump
    Given today is "2026-07-25 19:00:00 CDT"
    And a race exists for 2026
    And I am logged in as an admin
    When I follow "Current Race"
    And I press "Download Database"
    Then I should download a file named: "rw24-database-2026_07_25.sql"
