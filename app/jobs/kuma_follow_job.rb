class KumaFollowJob < ApplicationJob
  queue_as :default

  def perform(relationship)
    kuma = relationship.followed
    myself = relationship.follower
    unless kuma.following?(myself)
      kuma.follow!(myself)
    end
  end
end
