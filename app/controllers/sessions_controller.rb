class SessionsController < ApplicationController
  def new
  end

  def create
    if @user = login(params[:email], params[:password], params[:remember_me])
      redirect_back_or_to @user
    else
      flash.now[:danger] = "Incorrect email/password"
      render 'new'
    end
  end

  def destroy
    logout
    redirect_to root_url
  end
end
