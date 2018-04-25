class AddImagesToReviews < ActiveRecord::Migration[5.1]
  def change
    add_reference :reviews, :image, foreign_key: true
  end
end
