class Post < ActiveRecord::Base

  belongs_to :user

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  has_many :favourites, dependent: :destroy
  has_many :favouriting_users, through: :favourites, source: :user

  has_many :comments, dependent: :destroy
  has_many :commenting_users, through: :comments, source: :user

  validates :title, presence: {message: "Title is required"},
                      length: {minimum: 5, message: "Minimum 5 characters"}

  validates :body,  presence: {message: "Body is required"},
                  uniqueness: {scope: :title, message: "Title-body combinations must be unique"}

  def favourited_by?(user)
    favourite_for(user).present?
  end

  def favourite_for(user)
    favourites.find_by_user_id user.id
  end


end
