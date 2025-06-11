module Api
  module V1
    class ChatsController < ApplicationController
      protect_from_forgery with: :null_session

      def index
        user = User.find(params[:user_id])

        chats_json = user.chats.as_json
        for i in 0..chats_json.length - 1
          users = user.chats[i].users.map { |u| { id: u.id, name: u.name } }
          chats_json[i].merge!(users: users)
          chats_json[i].merge!(last: "#{user.chats[i].messages.last.user.name}: #{user.chats[i].messages.last.body}")
          chats_json[i].merge!(n_unread: user.chats[i].messages.count - user.chats[i].messages.find_index {
            |msg| msg.id == user.chats[i].last_vieweds.find_by(user_id: params[:user_id]).message.id } - 1)
        end

        render json: chats_json, status: :ok
      end

      def show
        chat = Chat.find(params[:id])
        messages_json = chat.messages.as_json
        for i in 0..messages_json.length - 1 do
          messages_json[i].merge!(name: User.find(chat.messages[i].user_id).name)
        end
        render json: messages_json, status: :ok
      end

      def create
        user = User.find(params[:user_id])
        chat = Chat.create(name: params[:name])
        message = chat.messages.create(body: "Создал чат", user: user)
        user.last_vieweds.create(chat: chat, message: message)
        users = [{id: user.id, name: user.name}] + params[:users_ids].map do |id|
          u = User.find(id)
          u.last_vieweds.create(chat: chat, message: message)
          return { id: id, name: u.name }
        end

        chat_json = chat.as_json
        chat_json.merge!(last: "")
        chat_json.merge!(n_unread: 0)
        chat_json.merge!(users: users)
        render json: chat_json, status: :ok
      end

      def update_users
        chat = Chat.find(params[:id])
        user = User.find(params[:user_id])
        user.last_vieweds.create(chat: chat, message: chat.messages.first)
      end
    end
  end
end