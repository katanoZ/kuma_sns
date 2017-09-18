class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    Talk.create!(content: data['talk'], user_id: data['user_id'], chat_id: data['chat_id'])
  end
end
