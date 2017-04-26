require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let(:follower) { FactoryGirl.create(:user) }
  let(:followed) { FactoryGirl.create(:user) }
  let(:relationship) { follower.relationships.build(followed_id: followed.id) }

  it "creates valid relationship" do
    expect(relationship).to be_valid
  end

  describe "follower methods" do
    it { expect(relationship).to respond_to(:follower) }
    it { expect(relationship).to respond_to(:followed) }
  end

  describe "when followed id is not present" do
    before { relationship.followed_id = nil }
    it { expect(relationship).to_not be_valid }
  end

  describe "when follower id is not present" do
    before { relationship.follower_id = nil }
    it { expect(relationship).to_not be_valid }
  end
end
