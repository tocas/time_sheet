Feature: Can go to pages

Scenario: Go to Contact page
    Given I am on the home page
	When I follow "Contact"
	Then I should see "contact"
	And I should be on the contact page
	
	
Scenario: Go to About page
	Given I am on the home page
	When I follow "About"
	Then I should see "About"
	And I should be on the about page

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
	