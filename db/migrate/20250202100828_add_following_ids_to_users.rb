class AddFollowingIdsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :following_ids, :json
  end
end
