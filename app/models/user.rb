class User < ApplicationRecord
    has_secure_password
  
    validates :name, :email, presence: true
    validates :email, uniqueness: true
  
    has_many :posts
    has_many :comments
    has_many :likes

    def generate_jwt
        payload = { user_id: self.id, exp: 24.hours.from_now.to_i }
        JWT.encode(payload, ApplicationController::SECRET_KEY)
      end
      
  end
  