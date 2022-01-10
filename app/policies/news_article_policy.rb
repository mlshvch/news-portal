# frozen_string_literal: true

class NewsArticlePolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    user.present? && user.has_role?(:correspondent)
  end

  def update?
    (create? && (record.user_id == user.id)) || user.has_any_role?(:editor, :admin)
  end

  def destroy?
    update?
  end

  private

  def article
    record
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all if user.present?
    end

    private

    attr_reader :user, :scope
  end
end
