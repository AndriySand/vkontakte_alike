class Article < ActiveRecord::Base
  belongs_to :author, class_name: 'User'
  validates :title, presence: true, length: {minimum: 8}
  validates :author_id, presence: true
end
