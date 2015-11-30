class CommentsController < ApplicationController
  def create
    comment_params = params.require(:comment).permit(:body)

    @post = Post.find params[:post_id]

    @comment = current_user.comments.new(comment_params)
    # this associates the @comment with question `q`
    @comment.post = @post
    # byebug
    respond_to do |format|
      if @comment.save
        #commentsMailer.notify_question_owner(@comment).deliver_later
        # redirect_to(question_path(q), {notice: "Answer created successfully!"})
        CommentMailer.notify_post_owner(@comment).deliver_later
        format.html { redirect_to post_path(@post) }
        # this will render views/answers/create_success.js.erb
        format.js { render :add_comment }
      else
        # flash[:alert] = @answer.errors.full_messages.join(", ")
        format.html { render 'posts/show' }
        format.js   { render js: "$(\"#new_answer\").replaceWith(\"#{j render 'form'}\");" }
      end
    end
  end

  def destroy
  @comment = Comment.find params[:id]
  redirect_to root_path, alert: "access denied!" unless can?(:destroy, @comment)
  @comment.destroy
  respond_to do |format|
    format.html { redirect_to post_path(@comment.post)}
    format.js   { render } # this renders /views/answers/destroy.js.erb
  end
  end
end
