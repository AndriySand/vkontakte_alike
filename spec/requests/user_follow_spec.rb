require "rails_helper"

RSpec.describe "When user", type: :request do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @other_user = FactoryGirl.create(:user)
  end

  context "not signed in and comes to another user's page" do
    before { get "/users/#{@other_user.id}" }

    it "he must not see the links of 'followed users' and 'following users' " do
      expect(response).to render_template(:show)
      expect(response.body).to_not include("<a href=\"/users/#{@other_user.id}/followers\">")
      expect(response.body).to_not include("<a href=\"/users/#{@other_user.id}/following\">")
    end

    it "he must not see the button which allows to follow or unfollow another user" do
      expect(response.body).to_not include("<div id=\"follow_form\">")
    end
  end

  context "sign in and comes to another user's page" do
    before(:each) do
      sign_in @user
      get "/users/#{@other_user.id}"
    end

    it "he must see the links of 'followed users' and 'following users' " do
      expect(response.body).to include("<a href=\"/users/#{@other_user.id}/followers\">")
      expect(response.body).to include("<a href=\"/users/#{@other_user.id}/following\">")
    end

    it "he must see the button which allows to follow another user" do
      expect(response.body).to include("<input type=\"submit\" name=\"commit\" value=\"Follow\"")
    end

    it "he must see number of followed and following users" do
      expect(response.body).to include("<strong> 0 </strong> following")
      expect(response.body).to include("<strong> 0 </strong> followers")
    end

    it "and starts to follow him it should increment the followed user count" do
      expect { @user.follow!(@other_user) }.to change(@user.followed_users, :count).by(1)
    end

    it "and starts to follow him it should increment the other user's followers count" do
      expect { @user.follow!(@other_user) }.to change(@other_user.followers, :count).by(1)
    end

    context "and choosed to follow another user" do
      before(:each) do
        @user.follow!(@other_user)
        get "/users/#{@other_user.id}"
      end

      it "he must see the button which allows to unfollow another user" do
        expect(response.body).to include("<input type=\"submit\" name=\"commit\" value=\"Unfollow\"")
      end

      it "he must see that number of followed users increased" do
        expect(response.body).to include("<strong> 0 </strong> following")
        expect(response.body).to include("<strong> 1 </strong> followers")
      end

      it "and then return to his own page he must see that number of following users increased" do
        get "/users/#{@user.id}"
        expect(response.body).to include("<strong> 1 </strong> following")
        expect(response.body).to include("<strong> 0 </strong> followers")
      end

      it "and then to unfollow him it should decrement the followed user count" do
        expect { @user.unfollow!(@other_user) }.to change(@user.followed_users, :count).by(-1)
      end

      it "and then to unfollow him it should decrement the other user's followers count" do
        expect { @user.unfollow!(@other_user) }.to change(@other_user.followers, :count).by(-1)
      end
    end
  end

  context "sign in and comes to his own page" do
    before(:each) do
      sign_in @user
      get "/users/#{@user.id}"
    end

    it "he must not see the button which allows to follow or unfollow himself" do
      expect(response.body).to_not include("<div id=\"follow_form\">")
    end

    it "he must see number of followed and following users" do
      expect(response.body).to include("<strong> 0 </strong> following")
      expect(response.body).to include("<strong> 0 </strong> followers")
    end
  end
end