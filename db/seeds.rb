# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
10.times do |i|
  User.create(name: Faker::Name.name, email: Faker::Internet.email, password: 'password')
end

User.all.each do |user|
  10.times do |i|
    Article.create(title: Faker::Lorem.sentence, author_id: user.id, content: Faker::Lorem.paragraph)
  end
end

articles = Article.all
User.all.each do |user|
  articles.each do |article|
    5.times do |comment|
      article.comments.create(author_id: user.id, content: Faker::Lorem.sentence(3))
    end
  end
end
