class ChatsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "ChatsChannel"
  end

  def unsubscribed
    user = User.find(params[:id])
    for lv in user.last_vieweds do
      lv.message = lv.chat.messages.last
      lv.save
    end
  end
end
