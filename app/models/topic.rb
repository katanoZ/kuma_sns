class Topic < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  default_scope {order(id: :desc)}

  mount_uploader :image, ImageUploader

  validates :title, :content, presence: true
  validates :content, format: {with: /[(くま)(クマ)(熊)(bear)(ぱんだ)(パンダ)(panda)]/, message: "には「くま」「クマ」「熊」などの語句を含めてください (ᵔᴥᵔ)"}

  after_create_commit do
    unless self.user.provider == "kuma_provider"
      kuma_followers = self.user.followers.find_all{|u| u.provider == "kuma_provider"}
      return if kuma_followers.blank?
      random = Random.new
      kuma_followers.each do |kuma|
        KumaCommentJob.set(wait: (random.rand(60)).seconds).perform_later(self, kuma)
      end
    end
  end
end
