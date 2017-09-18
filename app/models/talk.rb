class Talk < ApplicationRecord
  belongs_to :chat
  belongs_to :user

  validates_presence_of :content, :chat_id, :user_id

  after_create_commit { TalkBroadcastJob.perform_later self }

  def talk_time
    created_at.strftime("%m/%d/%y at %l:%M %p")
  end
end
