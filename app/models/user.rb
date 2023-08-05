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

  def revenue
    total_revenue = 0

    self.posts.each do |post|
      # Calculate revenue for each post
      total_views = post.views.count
      free_views = 1 # Each user gets one free view per day
      paid_views = total_views > free_views ? total_views - free_views : 0

      # Find the price per view depending on the user's subscription plan
      price_per_view = case post.user.subscription.plan_id
                       when 'plan_3_per_day'
                         3.0 / 3 # $3 for 3 views
                       when 'plan_5_per_day'
                         5.0 / 5 # $5 for 5 views
                       when 'plan_10_per_day'
                         10.0 / 10 # $10 for 10 views
                       else
                         0 # For free plan or any other cases
                       end

      # Calculate revenue for this post
      post_revenue = paid_views * price_per_view

      # Accumulate the total revenue
      total_revenue += post_revenue
    end

    # Apply the platform's cut (30%)
    revenue_after_platform_cut = total_revenue * 0.7

    # Return the revenue per user
    revenue_after_platform_cut
  end
end
      

  