class Admin::UsersController < ApplicationController
  
  before_filter :non_admin


  def new
    @user = User.new
  end

  def index
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to movies_path, notice: "Welcome aboard, #{@user.firstname}!"
    else
      render :new
    end
  end
   
  protected

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation)
  end

  def non_admin
    if !(session[:user_id] && current_user.is_admin)
      redirect_to movies_path, notice: "Access Denied SUCKA!! YOU AINT NO ADMIN yo!"
    end
  end


  
  
end