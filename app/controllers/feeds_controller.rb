# frozen_string_literal: true

class FeedsController < ApplicationController

  layout false

  def rss_index
    @news_articles = NewsArticle.all.order(created_at: :desc)
  end


end
