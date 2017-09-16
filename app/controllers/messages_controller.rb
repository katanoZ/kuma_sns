class MessagesController < ApplicationController
  before_action do
    @conversation = Conversation.find(params[:conversation_id])
  end

  def index
    @messages = @conversation.messages
    if @messages.length > 10
      @over_ten = true
      @messages = @messages[-10..-1]
    end

    if params[:m]
      @over_ten = false
      @messages = @conversation.messages
    end

    if @messages.last
      if @messages.last.user_id != current_user.id
       @messages.last.read = true
      end
    end

    @message = @conversation.messages.build
  end

  def create
    @message = @conversation.messages.build(message_params)
    if @message.save
      execute_kuma_message(@conversation)
    end
    redirect_to conversation_messages_path(@conversation)
  end

  private
  def message_params
    params.require(:message).permit(:body, :user_id)
  end

  def execute_kuma_message(conversation)
    sender = User.find(conversation.sender_id)
    recipient = User.find(conversation.recipient_id)
    if current_user.id == sender.id
      opponent = User.find(recipient.id)
    elsif current_user.id == recipient.id
      opponent = User.find(sender.id)
    end

    if opponent && opponent.provider == "kuma_provider"
      opponent.delay(run_at: 10.seconds.from_now).create_kuma_message(current_user)
    end
  end
end
