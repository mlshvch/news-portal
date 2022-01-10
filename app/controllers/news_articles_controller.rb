# frozen_string_literal: true

class NewsArticlesController < ApplicationController
  before_action :set_news_article, except: %i[index set_news_article news_article_params transition_not_allowed]
  before_action :authenticate_user!, except: :index

  rescue_from AASM::InvalidTransition, with: :transition_not_allowed

  # GET /news_articles
  def index
    @news_articles = policy_scope(NewsArticle.all)
  end

  # GET /news_articles/1
  def show; end

  # GET /news_articles/new
  def new
    @news_article = NewsArticle.new
  end

  # GET /news_articles/1/edit
  def edit; end

  # POST /news_articles
  def create
    @news_article = NewsArticle.new(news_article_params)
    @news_article.user = current_user
    authorize @news_article

    respond_to do |format|
      if @news_article.save
        format.html { redirect_to @news_article, notice: 'News article was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /news_articles/1
  def update
    authorize @news_article
    respond_to do |format|
      if @news_article.update(news_article_params)
        format.html { redirect_to @news_article, notice: 'News article was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /news_articles/1
  def destroy
    authorize @news_article
    @news_article.destroy!
    respond_to do |format|
      format.html { redirect_to news_articles_url, notice: 'News article was successfully destroyed.' }
    end
  end

  def approve_news
    @news_article.approve!
    redirect_to news_article_url
  end

  def publish_news
    DelayedPublicationJob.set(wait: 3.second).perform_now(@news_article)
    redirect_to news_article_url
  end

  def retract_news
    @news_article.not_active!
    redirect_to news_article_url
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
    params.require(:news_article).permit(:title, :body, :description, :main_image)
  end

  def transition_not_allowed
    flash[:notice] = 'Transition not allowed'
    redirect_to root_path
  end
end
