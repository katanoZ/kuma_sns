class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :topic
  has_many :notifications, dependent: :destroy
  default_scope {order(:id)}

  validates :content, presence: true

  after_create_commit do
    if kuma_topic_and_user_comment?
      random = Random.new
      KumaCommentJob.set(wait: (random.rand(60)).seconds).perform_later(self.topic, self.topic.user)
    elsif user_topic_and_another_user_comment?
      Pusher.trigger("user_#{self.topic.user_id}_channel", 'notification_created', {
        unread_counts: Notification.where(user_id: self.topic.user.id, read: false).count
      })
    end
  end

  private
  def kuma_topic_and_user_comment?
    topic.user.provider == "kuma_provider" && user.provider != "kuma_provider" ? true : false
  end

  def user_topic_and_another_user_comment?
    topic.user.provider != "kuma_provider" && user.provider != "kuma_provider" && user != topic.user ? true : false
  end
end
