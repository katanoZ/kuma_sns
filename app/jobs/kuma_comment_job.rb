class KumaCommentJob < ApplicationJob
  queue_as :default

  def perform(topic, kuma)
    kuma.create_kuma_comment(topic)
  end
end
