class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id # immediately set session
      redirect_to root_path, notice: "User #{user_params[:email]} created successfully!"
    else # if signup fails
      render :new
    end
  end

  private

  def user_params # santinize
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
