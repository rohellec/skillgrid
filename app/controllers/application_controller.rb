class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :save_current_url, only: [:get, :index, :show]

  def correct_user?(user)
    user == current_user
  end

  def save_current_url
    session[:url] = request.original_url
  end

  def current_url
    session[:url]
  end
end
