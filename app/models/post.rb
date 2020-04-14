class Post < ApplicationRecord
    has_and_belongs_to_many :tags
    has_many :comments, dependent: :destroy
    belongs_to :user
    validates :title, presence: true, length: { minimum: 2 }
    validates :description, presence: true, length: { minimum: 2 }
end