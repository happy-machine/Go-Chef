class Image < ApplicationRecord
  mount_uploaders :image, ImageUploader

  #this allows uploading of multiple images
  serialize :avatars, JSON # If you use SQLite, add this line.

  belongs_to :user
end
