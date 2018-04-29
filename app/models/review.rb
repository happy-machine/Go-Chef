class Review < ApplicationRecord
  
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100#" }, default_url: "no-image.jpg"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  belongs_to :user

  after_initialize :init

  def init
    self.rating  ||= 1   
  end
end
