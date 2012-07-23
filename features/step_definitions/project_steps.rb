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

Then /^I should be on the project page for "(.*?)"$/ do |project_name|
  current_path.should == project_path(Project.find_by_name!(project_name))
end

Then /^I should see "(.*?)"$/ do |message|
end

Then /^I should not see "(.*?)"$/ do |message|
  page.should_not have_content(message)
end

When /^I create a project$/ do
		click_button 'Create'
end

Given /^there is a project called "(.*?)"$/ do |name|
	Factory(:project, name: name)	
end

When /^I follow "(.*?)"$/ do |link_name|
	click_link link_name
end

When /^I fill in "(.*?)" with "(.*?)"$/ do |input_field, name|
	fill_in input_field, with: name
end

When /^I press "(.*?)"$/ do |button_name|
		click_button button_name
end
