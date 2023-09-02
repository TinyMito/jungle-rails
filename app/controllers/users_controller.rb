class UsersController < ApplicationController
  def new
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id # immediately set session
      redirect_to '/'
    else # if signup fails
      redirect_to '/signup', notice: 'Please fill in all the fields!'
    end
  end

  private

  def user_params # santinize
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
