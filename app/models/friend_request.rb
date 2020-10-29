class FriendRequest < ApplicationRecord
  belongs_to :requester, class_name: "User"
  belongs_to :requested, class_name: "User"

  scope :accepted, -> { where(accepted: true) }
  scope :pending, -> { where(accepted: nil) }
end
