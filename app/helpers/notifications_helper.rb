module NotificationsHelper
  def posted_time(time)
  time.in_time_zone('Tokyo').strftime('%Y年%m月%d日 %H時%M分%S秒')
  end

  def read_or_unread(read)
    read ? "既読" : "未読"
  end
end
