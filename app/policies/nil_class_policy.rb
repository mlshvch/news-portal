# frozen_string_literal: true

class NilClassPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.none
    end
  end
end
