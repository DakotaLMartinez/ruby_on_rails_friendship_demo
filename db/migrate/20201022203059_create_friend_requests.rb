class CreateFriendRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :friend_requests do |t|
      t.references :requester, null: false
      t.references :requested, null: false
      t.boolean :accepted

      t.timestamps
    end
  end
end
