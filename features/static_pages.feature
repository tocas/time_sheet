Feature: Can go to pages

Scenario: Go to Work page
	Given I am a new, authenticated user
	And I am on the home page
	When I follow "Work"
	Then I should see "Work list"
	And I should be on the works page
	
Scenario: Only authenticated user can get to Work page
	Given I am not authenticated 
	And I am on the home page
	When I follow "Work" 
	Then I should see "Please sign in."
	