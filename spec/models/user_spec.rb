require 'rails_helper'

RSpec.describe User, type: :model do
  user = FactoryGirl.create(:user, email: 'something@mail.qy')
  other_user = FactoryGirl.create(:user, email: 'something@mail.qu')

  describe "should have methods" do
    it { expect(user).to respond_to(:relationships) }
    it { expect(user).to respond_to(:followed_users) }
    it { expect(user).to respond_to(:following?) }
    it { expect(user).to respond_to(:follow!) }
    it { expect(user).to respond_to(:unfollow!) }
  end


end
