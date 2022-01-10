# frozen_string_literal: true

require 'rails_helper'
require 'faker'

RSpec.describe NewsArticlesController, type: :controller do
  context 'admin' do
    login_user
    before(:each) { subject.current_user.add_role(:admin) }
    let(:params) do
      { title: Faker::Educator.university, body: Faker::Educator.degree,
        user: subject.current_user }
    end
    let(:news_article_id) { NewsArticle.where(user_id: subject.current_user.id).last.id }
    let(:update_params) do
      { id: news_article_id, title: Faker::Educator.university, body: Faker::Educator.degree }
    end

    it "can't create news article" do
      post :create, params: { news_article: params }
      expect(response).to have_http_status(302)
      expect(subject).to redirect_to news_articles_path
    end

    it 'can delete news article' do
      NewsArticle.new(params).save!
      delete :destroy, params: { id: news_article_id }
      expect(subject).to redirect_to news_articles_url
      expect(flash[:notice]).to eql('News article was successfully destroyed.')
    end

    it 'can update news article' do
      NewsArticle.new(params).save!
      patch :update, params: { id: news_article_id, news_article: update_params }
      expect(subject).to redirect_to action: :show, id: news_article_id
      expect(flash[:notice]).to eql('News article was successfully updated.')
    end
  end

  context 'reader' do
    login_user
    let(:params) do
      { title: Faker::Educator.university, body: Faker::Educator.degree,
        user: subject.current_user }
    end
    let(:news_article_id) { NewsArticle.where(user_id: subject.current_user.id).last.id }
    let(:update_params) do
      { id: news_article_id, title: Faker::Educator.university, body: Faker::Educator.degree }
    end

    it 'is not allowed to create news article' do
      post :create, params: { news_article: params }
      expect(response).to have_http_status(302)
      expect(subject).to redirect_to news_articles_path
    end

    it 'is not allowed to delete news article' do
      NewsArticle.new(params).save!
      delete :destroy, params: { id: news_article_id }
      expect(response).to have_http_status(302)
      expect(subject).to redirect_to news_articles_path
    end

    it 'is not allowed to update news article' do
      NewsArticle.new(params).save!
      patch :update, params: { id: news_article_id, news_article: update_params }
      expect(response).to have_http_status(302)
      expect(subject).to redirect_to news_articles_path
    end
  end

  context 'correspondent' do
    login_user
    before(:each) do
      user = FactoryBot.create(:user)
      user.save
      NewsArticle.new(title: Faker::Educator.university, body: Faker::Educator.degree,
                      user: user).save!
      @fake_user_id = user.id
      subject.current_user.add_role(:correspondent)
    end
    let(:fake_news_article_id) { NewsArticle.where(user_id: @fake_user_id).last.id }

    let(:params) do
      { title: Faker::Educator.university, body: Faker::Educator.degree,
        user: subject.current_user }
    end
    let(:news_article_id) { NewsArticle.where(user_id: subject.current_user.id).last.id }
    let(:update_params) do
      { id: news_article_id, title: Faker::Educator.university, body: Faker::Educator.degree }
    end

    it 'can create news article' do
      post :create, params: { news_article: params }
      expect(subject).to redirect_to action: :show, id: news_article_id
      expect(flash[:notice]).to eql('News article was successfully created.')
    end

    it 'can delete his news article' do
      post :create, params: { news_article: params }
      delete :destroy, params: { id: news_article_id }
      expect(subject).to redirect_to news_articles_url
      expect(flash[:notice]).to eql('News article was successfully destroyed.')
    end

    it 'can update his news article' do
      post :create, params: { news_article: params }
      patch :update, params: { id: news_article_id, news_article: update_params }
      expect(subject).to redirect_to action: :show, id: news_article_id
      expect(flash[:notice]).to eql('News article was successfully updated.')
    end

    it "not allowed to edit others' articles" do
      post :create, params: { news_article: params }
      patch :update, params: { id: fake_news_article_id, news_article: update_params }
      expect(response).to have_http_status(302)
      expect(subject).to redirect_to news_articles_path
    end

    it "not allowed to delete others' articles" do
      post :create, params: { news_article: params }
      patch :update, params: { id: fake_news_article_id, news_article: update_params }
      expect(response).to have_http_status(302)
      expect(subject).to redirect_to news_articles_path
    end
  end
end
