class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show, :destroy]

  def new
    @user = User.new
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def create
    @user = User.new(user_params)

    if (@user.save)
      session[:user_id] = @user.id
      flash[:success] = "Welcome to Alpha Blogs, #{@user.username}"
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def edit
    if (logged_in? && current_user.username != @user.username)
      flash[:warning] = "You cannot edit someone else's profile"
      redirect_to user_path(current_user)
    end
  end

  def update
    if @user.update(user_params)
      flash[:success] = "user has been updated."
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def destroy
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
