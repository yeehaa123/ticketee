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

Then /^I should( not)? see "([^"]*)"$/ do |negate, message|
	negate ? page.should_not(have_content(message)) : page.should(have_content(message))
end

Then /^I should see( not)? "([^"]*)" within "([^"]*)"$/ do |negate, text, selector|
	if negate
		page.should_not have_selector selector, content: text
	else
		page.should have_selector selector, content: text
	end 
end

When /^I create a project$/ do
		click_button 'Create'
end

Given /^there is a project called "(.*?)"$/ do |name|
	@project = Factory(:project, name: name)	
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

Given /^that project has a ticket:$/ do |table|
	table.hashes.each do |attributes|
		@project.tickets.create!(attributes)
	end
end

