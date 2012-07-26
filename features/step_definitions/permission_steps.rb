permission_step = /^"(.*?)" can ([^"]*?) ([o|i]n)?\s?the "(.*?)" project$/

Given permission_step do |user, permission, on, project|
	create_permission(user, find_project(project), permission)
end

def create_permission(email, object, action)
	permission 					= Permission.new
	permission.user 		= User.find_by_email!(email)
	permission.thing 		= object
	permission.action 	= action
	permission.save!
end



# Given /^"(.*?)" can view the "(.*?)" project$/ do |email, project|
# 	permission 					= Permission.new
# 	permission.user 		= User.find_by_email!(email)
# 	permission.thing 		= find_project(project)
# 	permission.action 	= "view"
# 	permission.save!
# end

# Given /^"(.*?)" can create tickets in the "(.*?)" project$/ do |email, project|
#   permission 					= Permission.new
# 	permission.user 		= User.find_by_email!(email)
# 	permission.thing 		= find_project(project)
# 	permission.action 	= "create tickets"
# 	permission.save!
# end


def find_project(name)
 	Project.find_by_name!(name)
end