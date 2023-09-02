class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password]) # check user params match to db
      session[:user_id] = user.id # set user id to session
      redirect_to '/'
    else # if fails
      redirect_to '/login', notice: 'Wrong email or password, please try again!'
    end
  end

  def destroy #clear session to nil
    session[:user_id] = nil
    redirect_to '/login'
  end
end
