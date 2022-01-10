# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include Pundit
  after_action :verify_authorized, except: :index, unless: :devise_controller?
  after_action :verify_policy_scoped, only: :index

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from AASM::InvalidTransition, with: :transition_not_allowed

  private

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action'
    redirect_to news_articles_path
  end

  def transition_not_allowed
    flash[:notice] = 'Transition not allowed'
    redirect_to :back
  end
end
