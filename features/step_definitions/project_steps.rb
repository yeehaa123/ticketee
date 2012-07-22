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
  page.should have_content(message)
end

When /^I create a project$/ do
		click_button 'Create'
end