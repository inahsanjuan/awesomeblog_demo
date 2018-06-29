class User < ApplicationRecord
  has_many :microposts, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :active_relationships,   class_name: "Relationship",
                                    foreign_key: "follower_id",
                                    dependent: :destroy

  has_many :passive_relationships,  class_name: "Relationship",
                                    foreign_key: "followed_id",
                                    dependent: :destroy

  has_many :following,  through: :active_relationships,
                        source: :followed
  has_many :followers,  through: :passive_relationships,
                        source: :follower

  has_many :voting,     through: :votes,
                        source: :micropost

  before_save { email.downcase! }

  # constant variable with regular expression value
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true,
            length: { maximum: 255 },
            format: { with:  VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  has_secure_password # method that lets us use password authentication
  # authenticate method

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    following.delete(other_user)
  end

  def following?(other_user)
    following.include?(other_user)
  end

  # Return all microposts from following users
  def feed
    Micropost.where("user_id IN (?) OR user_id = ?", following_ids, id)
  end

  def voted?(micropost)
    voting.include?(micropost)
  end
end
