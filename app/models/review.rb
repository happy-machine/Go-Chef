class Review < ApplicationRecord
  belongs_to :user
  belongs_to :image, optional: true

  after_initialize :init

  def init
    self.rating  ||= 1   
  end
end
