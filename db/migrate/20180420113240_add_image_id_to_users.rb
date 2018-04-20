class AddImageIdToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :images, :user_id, :integer
    add_index :images, :user_id
  end
end
