# frozen_string_literal: true

class NewsArticlePolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    user.present?
  end

  def update?
    return true if user.present?
  end

  def destroy?
    return true if user.present?
  end

  private

  def article
    record
  end

  class Scope
    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    private

    attr_reader :user, :scope

    def resolve
      scope.all unless user.reader?
    end
  end
end
