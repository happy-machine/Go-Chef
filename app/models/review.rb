class Review < ApplicationRecord
  belongs_to :user
  has_many :images


  #   def average_rating 
  #   reviews.rating.map(&:rating).sum/rating.count
    
  # end
end
