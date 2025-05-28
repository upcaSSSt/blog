include ActionView::Helpers::DateHelper

module Api
  module V1
    class UsersController < ApplicationController
      def index
        users = User.all
        render json: users, status: :ok
      end

      def show
        user = User.find(params[:id])
        user_json = user.as_json
        ordered = user.posts.order(created_at: :desc)
        posts_json = ordered.as_json
        for i in 0..posts_json.length - 1 do
          images = ordered[i].images.map do |img|
            {
              id: img.id,
              url: url_for(img),
            }
          end
          posts_json[i].merge!(name: User.find(ordered[i].user_id).name)
          posts_json[i].merge!(time: time_ago_in_words(ordered[i].created_at))
          posts_json[i].merge!(images: images)
        end
        
        user_json.merge!(posts: posts_json)
        render json: user_json, status: :ok
      end
    end
  end
end
