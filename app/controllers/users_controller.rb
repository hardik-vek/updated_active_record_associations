class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Sign Up Successfully."
      redirect_to events_path
    else
      render "new"
    end
  end

  def register_event
    @user = User.find_by(id: session[:user_id])
    @enrollment = @user.enrollments.create()
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
