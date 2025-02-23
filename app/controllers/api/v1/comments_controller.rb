module Api
  module V1
    class CommentsController < ApplicationController
      def create
        post = Post.find(params[:post_id])
        user = User.find(params[:user_id])
        comment = post.comments.create(body: params.require(:comment)[:body], user: user)
        render json: {comment: comment}, status: :ok
      end
    end
  end
end