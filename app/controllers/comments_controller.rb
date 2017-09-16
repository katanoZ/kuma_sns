class CommentsController < ApplicationController
  before_action :set_comment, only:[:edit, :update, :destroy]
  before_action :set_topic, only:[:edit, :update]

  def create
    @comment = current_user.comments.build(comment_params)
    @topic = @comment.topic
    unless @topic.user_id == @comment.user_id
      @notification = @comment.notifications.build(user_id: @topic.user.id, notification_type: "comment")
    end

    respond_to do |format|
      if @comment.save
        flash.now[:notice] = "コメントを投稿しました。"
        format.js { render :index }
        execute_kuma_comment_reply(@topic)

        Pusher.trigger("user_#{@comment.topic.user_id}_channel", 'notification_created', {
          unread_counts: Notification.where(user_id: @comment.topic.user.id, read: false).count
        })
      else
        format.js { render :index }
      end
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to topic_path(@topic), notice: "コメントを更新しました。"
    else
      render "edit"
    end
  end

  def destroy
    @comment.destroy
    flash.now[:notice] = "コメントを削除しました。"
    respond_to do |format|
      format.js {render :index}
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:topic_id, :content)
    end

    def set_comment
      @comment = Comment.find(params[:id])
    end
    def set_topic
      @topic = Comment.find(params[:id]).topic
    end

    def execute_kuma_comment_reply(topic)
      writer = User.find(topic.user_id)
      if writer.provider == "kuma_provider"
        writer.delay(run_at: 10.seconds.from_now).create_kuma_comment(topic)
      end
    end
end
