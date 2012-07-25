module ApplicationHelper
	def title(*parts)
		content_for :title do
			(parts << "Ticketee").join(" - ") unless parts.empty?
		end
	end

	def admins_only(&block)
		block.call if current_user.try(:admin?)
		nil
	end
end
