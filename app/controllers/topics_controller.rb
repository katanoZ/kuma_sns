class TopicsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_topic, only: [:show, :edit, :update, :destroy]

  def index
    user_ids = current_user.followed_users.ids
    user_ids << current_user.id
    @topics = Topic.where(user_id: user_ids).includes(:comments)
  end

  def new
    if params[:back]
      @topic = Topic.new(topic_params)
    else
      @topic = Topic.new
    end
  end

  def create
    @topic = Topic.new(topic_params)
    @topic.user_id = current_user.id
    if @topic.save
      redirect_to topics_path, notice: "トピックを作成しました"
      NoticeMailer.sendmail_topic(@topic).deliver
    else
      render "new"
    end
  end

  def show
    @comment = @topic.comments.build
    @comments = @topic.comments
    Notification.find(params[:notification_id]).update(read: true) if params[:notification_id]
    @notifications_count = Notification.where(user_id: current_user.id).where(read: false).count
  end

  def edit
  end

  def update
    if @topic.update(topic_params)
      redirect_to topics_path, notice: "トピックを編集しました"
    else
      render "edit"
    end
  end

  def destroy
    @topic.destroy
    redirect_to topics_path, notice: "トピックを削除しました"
  end

  private
  def topic_params
    params.require(:topic).permit(:title, :content, :image)
  end

  def set_topic
    @topic = Topic.find(params[:id])
  end
end
