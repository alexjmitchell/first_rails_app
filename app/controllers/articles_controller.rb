class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :show, :destroy]

  def new
    if logged_in?
      @article = Article.new
    else
      flash[:warning] = "you must login to create an article"
      redirect_to login_path
    end
  end

  def edit
    user = @article.user
    if (user.username != current_user.username)
      flash[:warning] = "You cannot edit someone else's article"
      redirect_to root_path
    end
  end

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def update
    if (@article.update(article_params))
      flash[:success] = "Article was successfully edited"
      redirect_to article_path(@article)
    else
      render :edit
    end
  end

  def create
    # render plain: params[:article].inspect // allows you to view what is being passed to article
    @article = Article.new(article_params)
    @article.user = helpers.current_user if helpers.logged_in?
    # @article.save
    # redirect_to article_path(@article)
    if (@article.save)
      flash[:success] = "Article was successfully created"
      redirect_to article_path(@article)
    else
      render :new
    end
  end

  def show
    @user = @article.user
  end

  def destroy
    @article.destroy
    flash[:danger] = "Article was deleted"
    redirect_to articles_path
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end
end
