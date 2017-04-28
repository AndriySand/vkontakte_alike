require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryGirl.create(:user) }
  let(:other_user) { FactoryGirl.create(:user) }
  before { user.follow!(other_user) }

  describe "should have methods" do
    it { expect(user).to respond_to(:relationships) }
    it { expect(user).to respond_to(:followed_users) }
    it { expect(user).to respond_to(:following?) }
    it { expect(user).to respond_to(:follow!) }
    it { expect(user).to respond_to(:unfollow!) }
    it { expect(user).to respond_to(:reverse_relationships) }
    it { expect(user).to respond_to(:followers) }
  end

  describe "after making relationship to other_user" do
    it "must be 'following?' to him" do
      expect(user).to be_following(other_user)
    end
    it "must be included into followed_users" do
      expect(user.followed_users).to include(other_user)
    end
    it "must be included into followers for 'other_user'" do
      expect(other_user.followers).to include(user)
    end
  end

  context "after break relationship to other_user" do
    before { user.unfollow!(other_user) }

    it "must not 'following?' to him" do
      expect(user).to_not be_following(other_user)
    end
    it "must not be included into followed_users" do
      expect(user.followed_users).to_not include(other_user)
    end
  end
end
