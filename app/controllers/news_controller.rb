class NewsController < ApplicationController
  # skip_before_action :verify_authenticity_token

  def index
    @articles = News.all
  end

  def show!
    find_article
    # if article nil then redirect to the main page
    unless @article 
      flash[:notice] = "Article not found"
      redirect_to root_path
    end
  end

  def new
    @article = News.new
  end

  def create!
    @article = News.new(news_params)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit!
    find_article
  end

  def update!
    find

    if @article.update(news_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy!
    find_article
    @article.destroy

    redirect_to root_path
  end

  private

  def find_article 
    @article = News.find(params[:id])
  end

  def news_params
    params.require(:news).permit(:title, :body)
  end

end
