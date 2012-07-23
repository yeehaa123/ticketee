class ProjectsController < ApplicationController
	before_filter :find_project, only: [:show, :edit, :update, :destroy]

	def index
		@projects = Project.all
	end

	def create
		@project = Project.new(params[:project])
		if @project.save
			redirect_to @project, notice: "Project has been created."
		else
			render action: "new", alert: "Project has not been created."
		end
	end

	def new
		@project = Project.new
	end

	def show
	end

	def edit
	end

	def update
		if @project.update_attributes(params[:project])
			redirect_to @project, notice: "Project has been updated."
		else
			render action: "edit", alert: "Project has not been updated."
		end
	end

	def destroy
		@project.destroy
		redirect_to projects_path, notice: "Project has been deleted"
	end	

	private
		
		def find_project
			@project = Project.find(params[:id])
			rescue ActiveRecord::RecordNotFound
			flash[:alert] = "The project you were looking for could not be found."
			redirect_to projects_path
		end

end
