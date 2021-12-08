class NewsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @articles = News.all
  end

  def show
    @article = News.find(params[:id])
  end

  def new
    @article = News.new
  end

  def create
    @article = News.new(news_params)

    if @news.save
      redirect_to @article
    else
      render new, status: :unprocessable_entity
    end
  end

  def edit
    @article = News.find(params[:id])
  end

  def update
    @article = News.find(params[:id])

    if @article.update(news_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = News.find(params[:id])
    @article.destroy

    redirect_to root_path
  end

  private

  def news_params
    params.require(:news).permit(:title, :body)
  end

end
