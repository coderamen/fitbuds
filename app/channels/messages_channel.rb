class MessagesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "messages_from_match#{params[:match_id]}"
  end

  def receive(data)
    message = Message.create(match_id: data["match_id"], user_id: data["user_id"], content: data["content"])
    ActionCable.server.broadcast("messages_from_match#{params[:match_id]}", { message: message.content, user_id: message.user_id })
  end

end