require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do

  before(:each) do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  let(:valid_attributes) { { title: "Some title here", content: "some text here" } }

  describe "POST create" do
    describe "with valid params" do
      it "creates a new article" do
        expect {
          post :create, article: valid_attributes
        }.to change(Article, :count).by(1)
      end

      it "assigns a newly created article as @article" do
        post :create, article: valid_attributes
        expect(assigns(:article)).to be_a(Article)
        expect(assigns(:article)).to be_persisted
      end

      it "shows the created article" do
        post :create, article: valid_attributes
        expect(response).to redirect_to(Article.last)
      end
    end

    describe "with invalid params" do
      it "doesn't create new article" do
        expect{
          post :create, article: { title: "" }
        }.to_not change(Article, :count)
      end

      it "renders the 'new' template" do
        post :create, article: { title: "" }
        expect(response).to render_template("new")
      end
    end
  end

  before(:each) do
    @article = FactoryGirl.create(:article)
  end

  describe "PUT update" do

    describe "with valid params" do

      before(:each) do
        put :update, id: @article.id, article: valid_attributes
        @article.reload
      end

      it "updates the requested article" do
        expect(@article.title).to eql valid_attributes[:title]
        expect(@article.content).to eql valid_attributes[:content]
      end

      it "redirects to 'show' action" do
        expect(response).to redirect_to(@article)
      end

    end

    describe "with invalid params" do

      before(:each) do
        put :update, id: @article.id, article: { title: "" }
        @article.reload
      end

      it "doesn't update requested article" do
        expect(@article.title).to_not eql ""
      end

      it "renders template 'edit'" do
        expect(response).to render_template("edit")
      end

    end

  end

  describe "DELETE destroy" do
    it "destroys the requested article" do
      expect {
        delete :destroy, {id: @article.id}
      }.to change(Article, :count).by(-1)
    end

    it "redirects to articles 'index' page" do
      delete :destroy, {id: @article.id}
      expect(response).to redirect_to(:articles)
    end
  end
end
