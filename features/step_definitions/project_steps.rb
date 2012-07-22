Given /^I am on the homepage$/ do
	visit('/ ')
end

When /^I go to the new project page$/ do
	  click_link('New Project')
end

When /^I create a project named "(.*?)"$/ do |project_name|
	fill_in 'Name', with: project_name
	click_button 'Create'
end

Then /^I should see the created project$/ do
	page.should have_content 'Project has been created'
end

Then /^I should be on the project page for "(.*?)"$/ do |arg1|
  current_path.should == project_path(Project.find_by_name!('TextMate 2'))
  page.should have_content("TextMate 2 - Projects - Ticketee")
end

Then /^I should see "(.*?)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end