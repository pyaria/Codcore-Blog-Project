class CommentMailer < ApplicationMailer
  def notify_post_owner(comment)
    @user = comment.user
    @post = comment.post
    mail(to: @post.user.email, subject: "#{@user.name} commented on your post")
  end
end
