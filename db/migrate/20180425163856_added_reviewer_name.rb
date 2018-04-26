class AddedReviewerName < ActiveRecord::Migration[5.1]
  def change
    add_column :reviews, :reviewer_name, :string
  end
end
