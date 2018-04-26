class IsAChef < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :is_a_chef, :boolean
  end
end
