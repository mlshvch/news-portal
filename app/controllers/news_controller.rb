class NewsController < ApplicationController
  # skip_before_action :verify_authenticity_token
  before_action :find_article, except: [:index, :find_article, :news_params]

  def index
    @articles = News.all
  end

  def show
    # if article nil then redirect to the main page
  end

  def new
  end

  def create
    @article = News.new(news_params)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @article.update(news_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy

    redirect_to root_path
  end

  private

  def find_article 
    @article = News.find_by(id: params[:id])

    unless @article 
      flash[:notice] = "Article not found"
      redirect_to root_path
    end
  end

  def news_params
    params.require(:news).permit(:title, :body)
  end

end
