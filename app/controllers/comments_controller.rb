class CommentsController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    comment = post.comments.create(body: params.require(:comment)[:body], user: current_user)
    redirect_to post
  end
end