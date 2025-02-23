module Api
  module V1
    class PostsController < ApplicationController
      def index
        posts = Post.order(created_at: :desc)
        render json: {posts: posts}, status: :ok
      end

      def show
        post = Post.find(params[:id])
        render json: {
          post: post,
          images: post.images.map { |img| img.signed_id },
          comments: post.comments,
        }, status: :ok
      end

      def create
        post = current_user.posts.create! params.require(:post).permit(:body)
        render json: {post: post}, status: :ok
      end

      def update
        post = Post.find(params[:id])
        if post.update(params.require(:post).permit(:body))
          render json: {post: post}, status: :ok
        else
          render json: {}, status: :unprocessible_entity
        end
      end

      def destroy
        post = Post.find(params[:id])
        post.destroy
        render json: {message: "Deletes posts/#{params[:id]}"}, status: :ok
      end

      def purge_image
        image = ActiveStorage::Attachment.find(params[:id])
        image.purge
        render json: {message: "Deletes image #{params[:id]}"}, status: :ok
      end
    end
  end
end