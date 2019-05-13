class Comment < ApplicationRecord
    belongs_to :post
    validates :description, presence: true, length: { minimum: 1 }
end
