FactoryGirl.define do
  factory :comment do
    content "MyText"
    author_id 3
    article_id 1
  end
end
