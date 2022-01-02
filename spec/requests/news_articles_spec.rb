# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NewsArticlesController, type: :controller do
  describe 'GET /news_articles' do
    context 'when user not logged-in' do
      it 'returns status 302' do
        get :index
        expect(response).to have_http_status(302)
      end
    end

    context 'when user logged-in' do
      login_user
      it 'has a current_user' do
        # NOTE: you should remove the "validate_session" parameter if this was a scaffold-generated controller
        expect(subject.current_user).to_not eq(nil)
      end

      it 'returns code 200' do
        get :index
        expect(response).to have_http_status(200)
      end
    end
  end
end
