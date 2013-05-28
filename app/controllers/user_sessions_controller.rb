class UserSessionsController < ApplicationController
  def new
    @user_session = UserSession.new
    @return_to = params[:return_to]
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "Successfully logged in."
      redirect_to params[:return_to] || root_url
    else
      render :action => 'new'
    end
  end

  def destroy
    @user_session = UserSession.find # find sin nada porque no es un modelo 'normal'
    @user_session.destroy
    flash[:notice] = "Successfully logged out."
    redirect_to root_url
  end

end
