module Api
  module V1
    class MessagesController < ApplicationController
      protect_from_forgery with: :null_session
      def create
        chat = Chat.find(params[:id])
        user = User.find(params[:user_id])
        message = chat.messages.create(body: params.require(:body), user: user)
        message_json = message.as_json
        message_json.merge!(name: user.name)

        ActionCable.server.broadcast("ChatsChannel", message_json)
        render json: message_json, status: :created
      end
    end
  end
end