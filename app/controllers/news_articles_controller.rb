class NewsArticlesController < ApplicationController
  before_action :set_news_article, only: %i[show edit update destroy]

  # GET /news_articles or /news_articles.json
  def index
    @news_articles = NewsArticle.all
  end

  # GET /news_articles/1 or /news_articles/1.json
  def show
  end

  # GET /news_articles/new
  def new
    @news_article = NewsArticle.new
  end

  # GET /news_articles/1/edit
  def edit
  end

  # POST /news_articles or /news_articles.json
  def create
    @news_article = NewsArticle.new(news_article_params)

    respond_to do |format|
      if @news_article.save
        format.html { redirect_to @news_article, notice: "News article was successfully created." }
        format.json { render :show, status: :created, location: @news_article }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @news_article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /news_articles/1 or /news_articles/1.json
  def update
    respond_to do |format|
      if @news_article.update(news_article_params)
        format.html { redirect_to @news_article, notice: "News article was successfully updated." }
        format.json { render :show, status: :ok, location: @news_article }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @news_article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /news_articles/1 or /news_articles/1.json
  def destroy
    @news_article.destroy
    respond_to do |format|
      format.html { redirect_to news_articles_url, notice: "News article was successfully destroyed." }
      format.json { head :no_content }
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
