class User < ApplicationRecord
  include Kuma

  has_many :topics, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :followers, through: :reverse_relationships, source: :follower

  validates :name, presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable

  mount_uploader :avatar, AvatarUploader

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.find_by(email: auth.info.email)

    unless user
      user = User.new(
        name: auth.extra.raw_info.name,
        provider: auth.provider,
        uid: auth.uid,
        email: auth.info.email ||= "#{auth.uid}-#{auth.provider}@example.com",
        image_url: auth.info.image,
        password: Devise.friendly_token[0, 20]
      )
      user.skip_confirmation!
      user.save(validate: false)
    end
    user
  end

  def self.find_for_twitter_oauth(auth, signed_in_resource=nil)
    user = User.find_by(provider: auth.provider, uid: auth.uid)

    unless user
      user = User.new(
        name: auth.info.nickname,
        image_url: auth.info.image,
        provider: auth.provider,
        uid: auth.uid,
        email: auth.info.email ||= "#{auth.uid}-#{auth.provider}@example.com",
        password: Devise.friendly_token[0, 20]
      )
      user.skip_confirmation!
      user.save
    end
    user
  end

  def self.create_unique_string
    SecureRandom.uuid
  end

  def self.kuma_schedule
    kumas = User.where(provider: "kuma_provider")
    kumas.each do |kuma|
      kuma.create_kuma_topic
    end
  end

  def update_with_password(params, *options)
    if provider.blank?
      super
    else
      params.delete :current_password
      update_without_password(params, *options)
    end
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)

    unless other_user.provider == "kuma_provider"
      Notification.create(user_id: other_user.id, follower_id: self.id, notification_type: "follow")
      Pusher.trigger("user_#{other_user.id}_channel", 'notification_created', {
        unread_counts: Notification.where(user_id: other_user.id, read: false).count
      })
    end
  end

  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end

  def follow_each_other?(other_user)
    self.following?(other_user) && other_user.following?(self)
  end

  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy
  end

  def create_kuma_topic
    Topic.create(user_id: self.id, title: kuma_title, content: kuma_content, flickr_url: kuma_image)
  end

  def create_kuma_comment(topic)
    comment = self.comments.build({topic_id: topic.id, content: kuma_content})
    comment.save

    return if topic.user.provider == "kuma_provider"
    Notification.create(user_id: topic.user.id, comment_id: comment.id, notification_type: "comment")
    Pusher.trigger("user_#{comment.topic.user_id}_channel", 'notification_created', {
      unread_counts: Notification.where(user_id: comment.topic.user_id, read: false).count
    })
  end

  def get_kuma_content
    kuma_content
  end
end
