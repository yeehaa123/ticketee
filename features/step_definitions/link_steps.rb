Then /^I should( not)? see the "(.*?)" link$/ do |negate, text| 
	if negate 
		page.should_not have_css("a", text: text),
			"Expected not to see the #{ text.inspect } link, but did."			
	else
		page.should have_css("a", text: text),
				"Expected to see the #{ text.inspect } link, but did not."	
		end
end