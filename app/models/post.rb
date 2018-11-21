class Post < ApplicationRecord
  validates :content, presence: true
  belongs_to :group, counter_cache: true 
  belongs_to :user

  scope :recent, -> { order("updated_at DESC")}
end
