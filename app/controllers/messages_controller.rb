class MessagesController < ApplicationController
  before_action :require_login
  before_action :require_user_details

  def create
    current_user_authorised_for_match?(Match.find_by_id(params[:match_id]))

    @message = Message.new(get_message)
    @message.user_id = current_user.id
    @message.match_id = params[:match_id]

    if @message.save
      flash[:success] = "Sent message!"
      redirect_to user_match_path(user_id: current_user.id, id: params[:match_id])
    else
      flash[:danger] = "Failed to send message"
      redirect_to user_match_path(user_id: current_user.id, id: params[:match_id])
    end
  end

  private

  def get_message
    params.require(:message).permit(:content)
  end
end
