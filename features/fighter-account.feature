Feature: Fighter Account
  Scenario: A New Fighter Joins The Club
    Given A weakling with a Google account
    When I login to 8th Fight
    Then I have joined the club

  Scenario: Viewing Results
    Given Fights have occured
    When I view all the fights
    Then I see the winners and losers
