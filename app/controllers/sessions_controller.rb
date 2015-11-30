class SessionsController < ApplicationController
  def new
  end

  def create
    respond_to do |format|
    user = User.find_by_email params[:session][:email]
      # byebug
      if user && user.authenticate(params[:session][:password])
        session[:user_id] = user.id
        format.js{ render js: "location.reload(); " }

      else
        format.js{ render '/sessions/login_fail.js.erb' }
      end
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :back
  end
end
