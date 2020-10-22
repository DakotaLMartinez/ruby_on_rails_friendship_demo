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
