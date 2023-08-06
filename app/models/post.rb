class Post < ApplicationRecord
    validates :title, :topic, :text, :published_at, presence: true
  
    belongs_to :user
    has_many :comments
    has_many :likes, counter_cache: :likes_count
    has_many :views
    has_many :post_themes
    has_many :themes, through: :post_themes
    
    validates :views_count, numericality: { greater_than_or_equal_to: 0 }
    validates :comments_count, numericality: { greater_than_or_equal_to: 0 }

    scope :by_title, -> (title) { where('title LIKE ?', "%#{title}%") }
    scope :by_author, -> (author_id) { where(user_id: author_id) }
    scope :by_topic, -> (topic) { where('topic LIKE ?', "%#{topic}%") }
    scope :by_date, -> (date) { where('created_at >= ? AND created_at <= ?', date.beginning_of_day, date.end_of_day) }
    
  end
  