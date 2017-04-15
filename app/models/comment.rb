class Comment < ActiveRecord::Base
  belongs_to :author, class_name: 'User'
  belongs_to :article
  validates :content, presence: true, length: {minimum: 4}
  validates :author_id, :article_id, presence: true
end
