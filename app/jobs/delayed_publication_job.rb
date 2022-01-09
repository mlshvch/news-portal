# frozen_string_literal: true

class DelayedPublicationJob < ApplicationJob
  queue_as :default

  def perform(news_article)
    news_article.publish!
  end
end
