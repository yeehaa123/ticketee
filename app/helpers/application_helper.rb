module ApplicationHelper
	def title(*parts)
		content_for :title do
			(parts << "Ticketee").join(" - ") unless parts.empty?
		end
	end
end
