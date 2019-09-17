class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    if params[:password] == params[:password_confirmation]
      @user = User.create(user_params)
      if @user.valid?
        session[:user_id] = @user.id
        redirect_to user_path(@user)
      else
        render :new
      end
    else
      flash[:message] = "Passwords do not match!"
      redirect_to new_user_path
    end
  end

  def show
    @user = current_user
  end

=begin
  def edit
    @user = current_user
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.update(user_params)
    if @user.valid?
      redirect_to user_path(@user)
    else
      render :edit
    end
  end
=end

  private

  def user_params
    params.require(:user).permit(:name, :password)
  end
end
