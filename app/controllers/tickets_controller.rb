class TicketsController < ApplicationController
	before_filter :authenticate_user!
	before_filter :find_project
	before_filter :find_ticket, only: [:show, :edit, :update, :destroy]

	def new
		@ticket = @project.tickets.build
	end

	def create
		@ticket = @project.tickets.build(params[:ticket].merge!(user: current_user))
		if @ticket.save
			redirect_to [@project, @ticket], notice: "Ticket has been created."
		else
			flash[:alert] = "Ticket has not been created."
			render action: "new"
		end
	end

	def show
	end
	
	def edit
	end

	def update
		if @ticket.update_attributes(params[:ticket])
			redirect_to [@project, @ticket], notice: "Ticket has been updated."
		else
			flash[:alert] = "Ticket has not been updated."
			render action: "edit"
		end
	end

	def destroy
		@ticket.destroy
		redirect_to @project, notice: "Ticket has been deleted."
	end

	private

		def find_ticket
			@ticket = @project.tickets.find(params[:id])
		end

		def find_project
			@project = Project.for(current_user).find(params[:project_id])
		rescue ActiveRecord::RecordNotFound
			redirect_to root_path, alert: "The project you were looking for could not be found."
		end
end
