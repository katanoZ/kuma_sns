class TalkBroadcastJob < ApplicationJob
  queue_as :default

  def perform(talk)
    ActionCable.server.broadcast 'chat_channel', talk: render_message(talk)
  end

  private
  def render_message(talk)
    ApplicationController.renderer.render(partial: 'talks/talk', locals: { talk: talk })
  end
end
