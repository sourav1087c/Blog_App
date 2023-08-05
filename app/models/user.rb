class User < ApplicationRecord
    has_secure_password
    has_many :posts
    has_many :comments
    has_many :likes
    has_many :views
    has_many :active_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
    has_many :passive_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
    has_many :following, through: :active_relationships, source: :followed
    has_many :followers, through: :passive_relationships, source: :follower
  
    validates :name, :email, presence: true
    validates :email, uniqueness: true
  
    has_many :posts
    has_many :comments
    has_many :likes

    def generate_jwt
        payload = { user_id: self.id, exp: 24.hours.from_now.to_i }
        JWT.encode(payload, ApplicationController::SECRET_KEY)
    end
    # Follows a user.
  def follow(other_user)
    following << other_user
  end

  # Unfollows a user.
  def unfollow(other_user)
    following.delete(other_user)
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end
      
  end
  