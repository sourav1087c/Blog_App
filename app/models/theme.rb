class Theme < ApplicationRecord
    has_many :post_themes
    has_many :posts, through: :post_themes
  end
  