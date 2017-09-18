class Talk < ApplicationRecord
  after_create_commit { TalkBroadcastJob.perform_later self }
end
