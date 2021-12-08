class NewsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @news = News.all
  end

  def show
    @news = News.find(params[:id])
  end

  def new
    @news = News.new
  end

  def create
    @news = News.new(news_params)

    if @news.save
      redirect_to @news
    else
      render new, status: :unprocessable_entity
    end
  end

  private

  def news_params
    params.require(:news).permit(:title, :body)
  end

end
