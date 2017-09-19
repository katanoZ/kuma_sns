class Talk < ApplicationRecord
  belongs_to :chat
  belongs_to :user

  default_scope {order(:id)}

  validates_presence_of :content, :chat_id, :user_id

  after_create_commit do
    if self.user.provider != "kuma_provider"
      TalkBroadcastJob.perform_now(self)
    else
      TalkBroadcastJob.set(wait: 3.seconds).perform_later(self)
    end
  end
end
