require 'rails_helper'

RSpec.describe NewsArticlePolicy, type: :policy do
  let(:user_1) { login_user }
  

  subject { described_class }


  permissions :show? do
    pp user_1
  end

  permissions :create? do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :update? do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :destroy? do
    pending "add some examples to (or delete) #{__FILE__}"
  end
end
