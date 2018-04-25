class Review < ApplicationRecord
  belongs_to :user
  has_one :image
  after_initialize :init

  def init
    self.rating  ||= 1   
  end
end
