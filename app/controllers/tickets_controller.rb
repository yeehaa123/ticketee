class TicketsController < ApplicationController
	before_filter :authenticate_user!
	before_filter :find_project
	before_filter :find_ticket, only: [:show, :edit, :update, :destroy]
	before_filter :authorize_create!, only: [:new, :create]
	before_filter :authorize_update!, only: [:edit, :update]
	before_filter :authorize_delete!, only: :destroy

	def new
		@ticket = @project.tickets.build
		@ticket.assets.build 
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
		@comment = @ticket.comments.build
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

		def authorize_create!
			if !current_user.admin? && cannot?(:"create tickets", @project)
				redirect_to @project, alert: "You cannot create tickets on this project."
			end
		end

		def authorize_update!
			if !current_user.admin? && cannot?(:"edit tickets", @project)
				redirect_to @project, alert: "You cannot edit tickets on this project."
			end
		end

		def authorize_delete!
			if !current_user.admin? && cannot?(:"delete tickets", @project)
				redirect_to @project, alert: "You cannot delete tickets from this project."
			end
		end
end
