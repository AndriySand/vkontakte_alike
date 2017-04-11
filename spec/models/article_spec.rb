require 'rails_helper'

RSpec.describe Article, type: :model do

  it "has a valid factory" do
    expect(FactoryGirl.create(:article)).to be_valid
  end

  it "is invalid without a title" do
    expect(FactoryGirl.build(:article, title: '')).to_not be_valid
  end

  it "is invalid without an author_id" do
    expect(FactoryGirl.build(:article, author_id: '')).to_not be_valid
  end

  it "belongs to an author" do
    user = FactoryGirl.create(:user)
    article = user.articles.create(title: 'something')
    expect(article.author_id).to eq(user.id)
  end

end
