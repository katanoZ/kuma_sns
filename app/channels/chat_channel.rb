class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_channel_#{params['chat_id']}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    Talk.create(content: data['talk'], user_id: data['user_id'], chat_id: data['chat_id'])
    execute_kuma_talk(data)
  end

  private
  def execute_kuma_talk(data)
    chat = Chat.find(data['chat_id'])
    user = User.find(data['user_id'])
    opponent = chat.target_user(user)
    if opponent.provider == "kuma_provider"
      Talk.create(content: opponent.get_kuma_content, user_id: opponent.id, chat_id: chat.id)
    end
  end
end
