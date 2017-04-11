class Article < ActiveRecord::Base
  belongs_to :author, class_name: 'User'
  validates :title, presence: true, length: {minimum: 8}
  validates :author_id, presence: true
  has_attached_file :photo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: ":style/missing.jpg"
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\z/
end
