class SessionsController < ApplicationController
  def new
  end

  def create
    if params && params[:user]
      @user = User.find_by(id: params[:user][:id])
      if @user && @user.authenticate(params[:user][:password])
        session[:user_id] = @user.id
        redirect_to user_path(@user)
      else
        flash[:message] = "Incorrect username or password!"
        redirect_to signin_path
      end
    elsif auth
      @user = User.find_or_create_by(name: auth['info']['name']) do |u|
        u.name = auth['info']['name']
        u.password = (0...8).map { (65 + rand(26)).chr }.join
      end
      session[:user_id] = @user.id
      @auth = auth
      redirect_to user_path(@user)
    else
      redirect_to signin_path
    end
  end

  def destroy
    session.delete(:user_id) if session[:user_id]
    redirect_to root_path
  end

  private

  def auth
    request.env['omniauth.auth']
  end
end
