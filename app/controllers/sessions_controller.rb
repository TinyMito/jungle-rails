class SessionsController < ApplicationController
  def new
    @session = Session.new #create new session
  end
  
  def create
    @session = Session.new(session_params) # set params

    if @session.valid? # if it is not nil
      user = User.find_by(email: @session.email) # look up User db email
      if user && user.authenticate(session_params[:password]) # check user password hash match input
        session[:user_id] = user.id # set user id to session
        redirect_to '/', notice: "User #{session_params[:email]} logged in successfully!"
      else # if fails the hash check
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
