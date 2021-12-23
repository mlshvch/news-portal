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
end
