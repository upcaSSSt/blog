module Api
  module V1
    class UsersController < ApplicationController
      def index
        users = User.all
        render json: {users: users}, status: :ok
      end

      def show
        user = User.find(params[:id])
        render json: {user: user, posts: user.posts}, status: :ok
      end
    end
  end
end
