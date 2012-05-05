Feature: Users autentification 

Scenario: Creating a new account
    Given I am not authenticated
    When I go to register
    And I fill in "email_input" with "foo@bar.com"
    And I fill in "password_input" with "secretpass"
    And I fill in "password_confirmation" with "secretpass"
    And I press "Sign up"
	Then I should be on the user page

Scenario: User can sign_in into application
  Given I am a new, authenticated user
  Then I should see "Work list"
  Then I should be on the works page
  
    

#Scenario: Willing to edit my account
#    Given I am a new, authenticated user # beyond this step, your work!
#    When I want to edit my account
#    Then I should see the account initialization form
#    And I should see "Your account has not been initialized yet. Do it now!"
    # And more view checking stuff