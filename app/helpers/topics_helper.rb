module TopicsHelper
  def comment_outline(topic)
    if topic.comments.present?
      "（" + topic.comments.count.to_s + "件のコメントがあります。）"
    else
      "（コメントはありません。）"
    end
  end
end
