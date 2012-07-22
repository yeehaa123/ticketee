Feature: Creating projects
	In order to have projects to assign tickets to
	As a user
	I want to create them easily

	Scenario: Creating a project
		Given I am on the homepage
		When I go to the new project page
		And I create a project named "TextMate 2" 
		Then I should see the created project
		And I should be on the project page for "TextMate 2"
		And I should see "TextMate 2 - Projects - Ticketee"