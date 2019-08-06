class Post < ApplicationRecord
    mount_uploaders :images, PostImagesUploader
    has_many :comments, dependent: :destroy
    validates :title, presence: true, length: { minimum: 2 }
    validates :description, presence: true, length: { minimum: 2 }
    validates :owner, presence: true
end