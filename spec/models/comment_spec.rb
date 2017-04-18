require 'rails_helper'

RSpec.describe Comment, type: :model do

  it "has a valid factory" do
    expect(FactoryGirl.create(:comment)).to be_valid
  end

  it "is invalid if content length less than 4 characters" do
    expect(FactoryGirl.build(:comment, content: 'som')).to_not be_valid
  end

  it "is invalid without an author_id" do
    expect(FactoryGirl.build(:comment, author_id: nil)).to_not be_valid
  end

  it "is invalid without an article_id" do
    expect(FactoryGirl.build(:comment, article_id: nil)).to_not be_valid
  end

  it "belongs to an author and article" do
    user = FactoryGirl.create(:user)
    article = FactoryGirl.create(:article)
    comment = user.comments.create(content: 'something', article_id: article.id)
    expect(comment.author_id).to eq(user.id)
    expect(comment.article_id).to eq(article.id)
  end

end
