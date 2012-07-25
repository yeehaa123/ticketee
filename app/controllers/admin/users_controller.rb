class Admin::UsersController < Admin::BaseController
  before_filter :find_user, only: [:show, :edit, :update, :destroy]

  def index
  	@users = User.all(order: "email")
  end

  def show
  end
  
  def new
    @user = User.new
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

  def edit
  end

  def update
    if params[:user][:password].blank?
      params[:user].delete(:password)
    end
    admin = params[:user].delete(:admin) 
    if @user.update_attributes(params[:user]) && @user.update_attribute("admin", admin == "1")
      redirect_to admin_users_path, notice: "User has been updated."
    else
      flash[:alert] = "User has not been updated."
      render action: "edit"
    end
  end

  def destroy
    if @user == current_user
      flash[:alert] = "You cannot delete yourself!"
    else
      @user.destroy
      flash[:notice] = "User has been deleted."
    end
    redirect_to admin_users_path
  end


  private
    def find_user
      @user = User.find(params[:id])      
    end
end
