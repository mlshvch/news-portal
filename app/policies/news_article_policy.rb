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

  def approve?
    user.present? && user.has_role?(:editor)
  end

  def publish?
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
