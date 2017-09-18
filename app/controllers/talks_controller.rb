class TalksController < ApplicationController
  before_action do
    @chat = Chat.find(params[:chat_id])
  end

  def index
    @talks = @chat.talks
    if @talks.length > 10
      @over_ten = true
      @talks = @talks[-10..-1]
    end

    if params[:m]
      @over_ten = false
      @talks = @chat.talks
    end

    if @talks.last
      if @talks.last.user_id != current_user.id
       @talks.last.read = true
      end
    end
  end
end
