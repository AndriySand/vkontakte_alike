require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  before(:each) do
    @user = FactoryGirl.create(:user)
    sign_in @user
    @article = FactoryGirl.create(:article)
    @comment = FactoryGirl.create(:comment)
  end

  let(:valid_attributes) { { content: "some text here", author_id: @user.id } }

  describe "PUT #update" do
    context "with valid params" do
      before(:each) do
        put :update, {article_id: @article.id, id: @comment, comment: valid_attributes}
        @comment.reload
      end

      it "updates the requested comment" do
        expect(@comment.content).to eq(valid_attributes[:content])
        expect(@comment.author_id).to eq(valid_attributes[:author_id])
      end

      it "respond with status 200" do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested comment" do
      expect {
        delete :destroy, {article_id: @article.id, id: @comment, format: :js}
      }.to change(Comment, :count).by(-1)
    end

    it "respond with status 200" do
      delete :destroy, {article_id: @article.id, id: @comment, format: :js}
      expect(response).to have_http_status(200)
    end
  end

end
