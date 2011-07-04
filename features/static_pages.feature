Feature: Can go to static pages

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
	
	