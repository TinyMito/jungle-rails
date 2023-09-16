class SessionsController < ApplicationController
  def new
    @session = Session.new #create new session
  end
  
  def create
    @session = Session.new(session_params) # set params

    if @session.valid? # if it is not nil
      if user = User.authenticate_with_credentials(params[:email], params[:password])
        # success logic, log them in
        session[:user_id] = user.id
        redirect_to '/', notice: "User #{session_params[:email]} logged in successfully!"
      else
        # failure, render login form
        @session.errors.add(:base, 'Wrong email or password, please try again!')
        render :new
      end
    else
      render :new
    end
  end

  def destroy #clear session to nil
    session[:user_id] = nil
    redirect_to '/login', notice: "User logged out successfully!"
  end

  private

  def session_params
    params.require(:session).permit(:email, :password) # required email and password
  end
end
