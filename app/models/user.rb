class User < ApplicationRecord
  Rails.application.config.active_record.belongs_to_required_by_default = false
  enum status: [:rating]
  has_many :reviews, -> { order(created_at: :desc) }
  has_many :ratings
  has_many :images

  after_initialize :init

  def init
    self.location_lat  ||= -0.09039        
    self.location_lon ||= 51.51264     
    self.range_to ||= 40 
    self.rating ||= average_rating
  end
  #carrierwave upload mounting
  mount_uploader :avatar, AvatarUploader

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def average_rating
      if reviews.count > 0 && (reviews.map(&:rating).compact.sum)/(reviews.map(&:rating).compact.count).round >= 1
        return (reviews.map(&:rating).compact.sum)/(reviews.map(&:rating).compact.count).round
    else 1
    end
  end

  def self.search(term)
    if term
      where('name LIKE ?', "%#{term}%")
    else
      all
    end
  end

end
