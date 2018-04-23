class RangeTo < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :range_to, :integer
  end

end