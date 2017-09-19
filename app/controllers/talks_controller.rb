class TalksController < ApplicationController
  before_action do
    @chat = Chat.find(params[:chat_id])
  end

  def index
    @talks = @chat.talks
    if @talks.length > 20
      @talks = @talks[-20..-1]
      @old = true
    end
  end
end
