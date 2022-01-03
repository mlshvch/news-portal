# frozen_string_literal: true

require 'rails_helper'
require 'faker'
RSpec.describe NewsArticlesController, type: :controller do
  context 'admin' do
    login_user
    before(:each) { subject.current_user.add_role(:admin) }
    let(:params) do
      { title: Faker::String.random(length: 10), body: Faker::String.random(length: 10..20), user: subject.current_user }
    end
    let(:news_article_id) { NewsArticle.where(user_id: subject.current_user.id).last.id }
    let(:update_params) {
      { id: news_article_id, title: Faker::String.random(length: 10), body: Faker::String.random(length: 10..20) }
    }

    it 'can create news article' do
      post :create, params: { news_article: params }
      expect(subject).to redirect_to action: :show, id: news_article_id
      expect(flash[:notice]).to eql('News article was successfully created.')
    end

    it 'can delete news article' do
      post :create, params: { news_article: params }

      delete :destroy, params: { id: news_article_id }
      expect(subject).to redirect_to news_articles_url
      expect(flash[:notice]).to eql('News article was successfully destroyed.')
    end

    it 'can update news article' do
      post :create, params: { news_article: params }

      patch :update, params: { news_article: update_params }

      expect(subject).to redirect_to action: :show, id: news_article_id
      expect(flash[:notice]).to eql('News article was successfully updated.')

    end

    it 'delete news article' do
      post :create, params: { news_article: params }

      delete :destroy, params: { id: news_article_id }
      expect(subject).to redirect_to news_articles_url
      expect(flash[:notice]).to eql('News article was successfully destroyed.')
    end

  end
end
