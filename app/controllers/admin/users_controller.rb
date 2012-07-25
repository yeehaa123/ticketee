class Admin::UsersController < Admin::BaseController

  def index
  	@users = User.all(order: "email")
  end

  def create
    admin = params[:user].delete(:admin) 
    @user = User.new(params[:user])
    if @user.save && @user.update_attribute("admin", admin == "1")
      redirect_to admin_users_path, notice: "User has been created."
    else
      flash[:alert] = "User has not been created."
      render action: "new"
    end
  end

  def new
    @user = User.new
  end
end
