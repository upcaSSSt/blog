module Api
  module V1
    class CommentsController < ApplicationController
      protect_from_forgery with: :null_session

      def create
        post = Post.find(params[:post_id])
        user = User.find(params[:user_id])
        comment = post.comments.create(body: params.require(:comment)[:body], user: user)
        render json: {comment: comment}, status: :created
      end
    end
  end
end