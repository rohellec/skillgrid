class UsersController < ApplicationController
  before_action :require_login, only: [:edit, :update]
  before_action :correct_user,  only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(@user.email, params[:user][:password])
      flash[:success] = "Welcome to Skillgrid"
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "User has been sucessfully updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    # Overriden method for "require_login" filter of sorcery gem
    def not_authenticated
      flash[:danger] = "Please log in first"
      redirect_to login_path
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to root_url unless correct_user?(@user)
    end
end
