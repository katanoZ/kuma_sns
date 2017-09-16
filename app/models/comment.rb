class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :topic
  has_many :notifications, dependent: :destroy
  default_scope {order(:id)}

  validates :content, presence: true
end
