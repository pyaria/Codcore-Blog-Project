class User < ActiveRecord::Base
  has_secure_password

  has_many :posts

  has_many :favourites, dependent: :nullify
  has_many :favourite_posts, through: :favourites, source: :post

  has_many :comments, dependent: :destroy
  has_many :commented_posts, through: :comments, source: :post

  validates :name,  presence: {message: "Name must not be blank"}

  validates :email, presence: {message: "Email must not be blank"},
                      format: {with: /@/, message: "Must be a valid email"},
                  uniqueness: {message: "This email has been used before"}
end
