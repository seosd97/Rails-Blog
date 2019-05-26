class User < ApplicationRecord
    enum role: { 'user': 0, 'admin': 1 }
    has_many :posts, dependent: :destroy
end
