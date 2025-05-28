include ActionView::Helpers::DateHelper

module Api
  module V1
    class PostsController < ApplicationController
      def index
        posts = Post.order(created_at: :desc)
        posts_json = posts.as_json

        for i in 0...posts_json.length do
          images = posts[i].images.map do |img|
            {
              id: img.id,
              url: url_for(img),
            }
          end
          posts_json[i].merge!(name: User.find(posts[i].user_id).name)
          posts_json[i].merge!(time: time_ago_in_words(posts[i].created_at))
          posts_json[i].merge!(images: images)
        end
        render json: posts_json, status: :ok
      end

      def show
        post = Post.find(params[:id])
        post_json = post.as_json
        images = post.images.map do |img|
          {
            id: img.id,
            url: url_for(img),
          }
        end

        ordered = post.comments.order(created_at: :desc)
        comments_json = ordered.as_json
        for i in 0..comments_json.length - 1
          comments_json[i].merge!(name: User.find(ordered[i].user_id).name)
          comments_json[i].merge!(time: time_ago_in_words(ordered[i].created_at))
        end

        post_json.merge!(name: User.find(post.user_id).name)
        post_json.merge!(time: time_ago_in_words(post.created_at))
        post_json.merge!(images: images)
        post_json.merge!(comments: comments_json)
        render json: post_json, status: :ok
      end

      def create
        user = User.find(params[:user_id])
        post = user.posts.create(body: params[:body])
        post.images.attach(params[:images])
        render json: post, status: :created
      end

      def update
        post = Post.find(params[:id])
        if post.update(body: params[:body])
          post.images.attach(params[:images])
          render json: post, status: :ok
        else
          render json: {}, status: :unprocessible_entity
        end
      end

      def destroy
        post = Post.find(params[:id])
        post.comments.destroy_all
        post.destroy
        render json: {message: "Deleted posts/#{params[:id]}"}, status: :no_content
      end

      def purge_image
        image = ActiveStorage::Attachment.find(params[:id])
        image.purge
        render json: {message: "Deleted image #{params[:id]}"}, status: :no_content
      end
    end
  end
end