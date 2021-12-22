class NewsArticlesController < ApplicationController
  before_action :set_news_article, only: %i[show edit update destroy], :authenticate_user!

  # GET /news_articles
  def index
    @news_articles = NewsArticle.all
  end

  # GET /news_articles/1
  def show
  end

  # GET /news_articles/new
  def new
    @news_article = NewsArticle.new
  end

  # GET /news_articles/1/edit
  def edit
  end

  # POST /news_articles
  def create
    @news_article = NewsArticle.new(news_article_params)

    respond_to do |format|
      if @news_article.save
        format.html { redirect_to @news_article, notice: "News article was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /news_articles/1
  def update
    respond_to do |format|
      if @news_article.update(news_article_params)
        format.html { redirect_to @news_article, notice: "News article was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /news_articles/1
  def destroy
    @news_article.destroy
    respond_to do |format|
      format.html { redirect_to news_articles_url, notice: "News article was successfully destroyed." }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_news_article
    @news_article = NewsArticle.find_by(id: params[:id])

    return if @news_article

    flash[:notice] = 'Article not found'
    redirect_to root_path
  end

  # Only allow a list of trusted parameters through.
  def news_article_params
    params.require(:news_article).permit(:title, :body)
  end
end
