class User < ApplicationRecord
  enum status: [:rating]
  has_many :reviews
  has_many :ratings
  has_many :images

  after_initialize :init

  def init
    self.location_lat  ||= -0.09039        
    self.location_lon ||= 51.51264     
    self.range_to ||= 40 
  end
  #carrierwave upload mounting
  mount_uploader :avatar, AvatarUploader

    # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def average_rating 
    #self.ratings.map(&:rating).sum/ratings.count
    3
      end

  def self.search(term)
    if term
      where('name LIKE ?', "%#{term}%")
    else
      all
    end

  end



end
