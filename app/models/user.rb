class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :articles, foreign_key: "author_id"
  validates :name, presence: true, length: {minimum: 4}
  has_many :comments, foreign_key: "author_id", dependent: :destroy
  validates :email, check_uniqueness: true
end
