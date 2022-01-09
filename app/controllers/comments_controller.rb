# frozen_string_literal: true

class CommentsController < ActionController::Base
  before_action :set_comment

  def create
    @news_article = NewsArticle.find(params[:news_article_id])
    @comment = Comment.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to news_article_url(news_article_id), notice: 'Comment was successfully created.' }
      else
        format.html do
          redirect_to news_article_url(news_article_id), notice: @comment.errors.full_messages.join(',').to_s
        end
      end
    end
  end

  def destroy
    @comment = Comment.destroy!

    respond_to do |format|
      format.html { redirect_to news_article_url(news_article_id), notice: 'Comment was successfully deleted.' }
    end
  end

  def update
    respond_to do |format|
      if @comment.update(news_article_params)
        format.html { redirect_to news_article_url(news_article_id), notice: 'News article was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  private

  def news_article_id
    comment_params[:news_article_id]
  end

  def set_comment; end

  def comment_params
    params.require(:comment).permit(:body, :news_article_id).merge(user: current_user)
  end
end
