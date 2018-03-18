class ConversationsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_user_permission, only: [:show]

  def index
  end

  def show
    @conversation = Conversation.find(params[:id])
  end

  def create
    @conversation = current_user.conversations.build(conversation_params)

    if @conversation.save
      redirect_to conversation_path(@conversation)
    else
      flash[:alert] = "An error has occured."
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def conversation_params
    params.permit(:friend_id)
  end

  def check_user_permission
    if current_user.conversations.where(id: params[:id]).empty? && current_user.inverse_conversations.where(id: params[:id]).empty?
      flash[:alert] = "Conversation does not exist."
      redirect_back(fallback_location: root_path)
    end
  end
end
