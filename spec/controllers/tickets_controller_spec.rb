require 'spec_helper'

describe TicketsController do
	let(:user) 		{ create_user! }
	let(:project)	{ Factory(:project) }
	let(:ticket)	{ Factory(:ticket, project: project, user: user) }

	context "standard users" do
		it "cannot access a ticket for a project" do
			sign_in(:user, user)
			get :show, id: ticket.id, project_id: project.id
			response.should redirect_to(root_path)
			flash[:alert].should == "The project you were looking for could not be found."
		end
	end

	context "with permission to view the project" do
		before do
			sign_in(:user, user)
			permission 					=	Permission.new
			permission.user 		= user
			permission.thing 		= project
			permission.action 	= "view"
			permission.save!
		end

		def cannot_create_tickets!
			response.should redirect_to(project)
			flash[:alert].should == "You cannot create tickets on this project."
		end

		def cannot_update_tickets!
			response.should redirect_to(project)
			flash[:alert].should == "You cannot edit tickets on this project."
		end

		it "cannot begin to create a ticket" do
			get :new, project_id: project.id
			cannot_create_tickets!
		end

		it "cannot create a ticket without permission" do
			post :create, project_id: project.id
			cannot_create_tickets!
		end

		it "cannot edit a ticket without permission" do
			get :edit, { project_id: project.id, id: ticket.id }
			cannot_update_tickets!
		end

		it "cannot create a ticket without permission" do
			put :update, { project_id: project.id, id: ticket.id, ticket: {} }
			cannot_update_tickets!
		end
	end
end
