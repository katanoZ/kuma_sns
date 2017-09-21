class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  after_create_commit do
    if self.followed.provider == "kuma_provider"
      KumaFollowJob.set(wait: 30.seconds).perform_later(self)
    end
  end
end
