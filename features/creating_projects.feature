Feature: Creating projects
	In order to have projects to assign tickets to
	As a user
	I want to create them easily

	Background:
		Given there are the following users:
			| email 							| password 	| admin |
			| admin@ticketee.com 	| password 	| true 	|
		And I am signed in as them
		Given I am on the homepage
		When I go to the new project page

	Scenario: Creating a project
		When I create a project named "TextMate 2" 
		Then I should see "Project has been created"
		And I should be on the project page for "TextMate 2"
		And I should see "TextMate 2 - Projects - Ticketee"

	Scenario: Creating a project without a name
		When I create a project 
		Then I should see "Project has not been created."
		And I should see "Name can't be blank"