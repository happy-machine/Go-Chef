class AddAvatarToReviews < ActiveRecord::Migration[5.1]
  def up
    add_attachment :reviews, :avatar
  end

  def down
    remove_attachment :reviews, :avatar
  end
end
