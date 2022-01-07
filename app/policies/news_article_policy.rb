# frozen_string_literal: true

class NewsArticlePolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    user.present? && user.has_any_role?(:admin, :correspondent, :editor)
  end

  def update?
    create? && ((user.has_role?(:correspondent) && (record.user_id == user.id)) || user.has_any_role?(:editor, :admin))
  end

  def destroy?
    create? && ((user.has_role?(:correspondent) && (record.user_id == user.id)) || user.has_any_role?(:editor, :admin))
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
      if user.present?

        if user.has_role?(:reader)
          scope.where(state: :published)
        else
          scope.all
        end
      else
        scope.where(access_rights: :avaliable_for_everyone, state: :published)
      end
    end

    private

    attr_reader :user, :scope
  end
end
