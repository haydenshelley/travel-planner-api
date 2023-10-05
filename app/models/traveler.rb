class Traveler < ApplicationRecord
  belongs_to :user
  belongs_to :trip

  def self.pending_invitations(user)
    where(user_id: user.id, accepted: false).pluck(:trip_id)
  end
end
