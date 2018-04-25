class Image < ApplicationRecord
  mount_uploader :image, ImageUploader

  #this allows uploading of multiple images
  # If you use SQLite, add this line.
  belongs_to :image
  belongs_to :user
end
