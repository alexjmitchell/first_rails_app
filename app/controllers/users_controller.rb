class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show, :destroy]

  def new
    @user = User.new
  end

  def index
    @users = User.all
  end

  def create
    @user = User.new(user_params)

    if (@user.save)
      flash[:success] = "Welcome to Alpha Blogs, #{@user.username}"
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def show
  end

  def update
  end

  def destroy
  end

  def update
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
