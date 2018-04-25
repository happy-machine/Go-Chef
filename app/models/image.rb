class Image < ApplicationRecord
  mount_uploader :image, ImageUploader

  #this allows uploading of multiple images
  # If you use SQLite, add this line.ß
  belongs_to :user
end
