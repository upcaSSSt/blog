module Api
  module V1
    class CommentsController < ApplicationController
      def create
        post = Post.find(params[:post_id])
        user = User.find(params[:user_id])
        comment = post.comments.create(body: params.require(:comment), user: user)
        render json: comment, status: :created
      end
    end
  end
end