class FilesController < ApplicationController
	before_filter :authenticate_user!
	
	def new
		@ticket = Ticket.new
		asset = @ticket.assets.build
		asset = Asset.new
		render 	partial: "files/form",
						locals: { number: params[:number].to_i,
											asset: asset }	
	end

	def show
		asset = Asset.find(params[:id])
		if can?(:view, asset.ticket.project)
			send_file asset.asset.path, filename: 		asset.asset_file_name, 
																	content_type:	asset.asset_content_type
		else
			redirect_to root_path, 
				alert: "The asset you were looking for could not be found."
		end
	end
end
