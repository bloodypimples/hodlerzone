class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @conversation = Conversation.find(params[:message][:conversation_id])
    @message = current_user.messages.new(message_params)
    @message.conversation_id = @conversation.id
    @conversation.mark_as_unread(current_user)

    if @conversation.user_has_permission?(current_user) && @message.save
      @conversation.update(updated_at: Time.zone.now)
      flash[:notice] = "Message sent."
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = "An error has occured."
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end
end
