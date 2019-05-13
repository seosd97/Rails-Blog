class Post < ApplicationRecord
    has_many :comments, dependent: :destroy
    has_many :post_likes, dependent: :destroy
    validates :title, presence: true, length: { minimum: 2 }
    validates :description, presence: true, length: { minimum: 2 }
end