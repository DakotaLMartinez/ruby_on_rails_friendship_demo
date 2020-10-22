# How to set up friendship between users in Ruby on Rails


## Dependencies (Gems/packages)

## Configuration (environment variables/other stuff in config folder)

## Database
```rb
ActiveRecord::Schema.define(version: 2020_10_22_203059) do

  create_table "friend_requests", force: :cascade do |t|
    t.integer "requester_id", null: false
    t.integer "requested_id", null: false
    t.boolean "accepted"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["requested_id"], name: "index_friend_requests_on_requested_id"
    t.index ["requester_id"], name: "index_friend_requests_on_requester_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
```
## Models
```rb
class User < ApplicationRecord
  has_many :friend_requests_as_requester, class_name: "FriendRequest", foreign_key: :requester_id
  has_many :friends_as_requester, -> { where(friend_requests: {accepted: true}) }, through: :friend_requests_as_requester, source: :requested
  has_many :friend_requests_as_requested, class_name: "FriendRequest", foreign_key: :requested_id
  has_many :friends_as_requested, -> { where(friend_requests: {accepted: true}) }, through: :friend_requests_as_requested, source: :requester
  
  def friends 
    ids = friends_as_requested.pluck(:id).concat(friends_as_requester.pluck(:id))
    User.where(id: ids)
  end
end

class FriendRequest < ApplicationRecord
  belongs_to :requester, class_name: "User"
  belongs_to :requested, class_name: "User"
end


```

## Views

## Controllers

## Routes
