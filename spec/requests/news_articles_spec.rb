# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NewsArticlesController, type: :controller do
  describe 'GET /news_articles' do
    context 'when user not logged-in' do
      it 'should return status 302' do
        get :index
        expect(response).to have_http_status(302)
      end
    end

    context 'when user logged-in' do
      login_user
      it 'should have a current_user' do
        # NOTE: the fact that you should remove the "validate_session" parameter if this was a scaffold-generated controller
        expect(subject.current_user).to_not eq(nil)
      end

      it 'should return code 200' do
        get :index
        expect(response).to have_http_status(200)
      end
    end
  end
end
