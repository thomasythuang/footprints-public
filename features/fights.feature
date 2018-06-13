Feature: FIGHTS

  Scenario: Logging Fight Results
    Given I have challenged another fighter
    And they have accepted
    When I log the results of the fight
    Then The results are shown with my matches
