class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_friendship, only: [:update, :destroy]

  def create
    @friend = User.find(params[:friend_id])
    if current_user != @friend && current_user.get_friendship(@friend).empty?
      @friendship = current_user.friendships.build(friend_id: @friend.id)
      if @friendship.save
        Notification.create(
          receiver_id: @friend.id,
          sender_id: current_user.id,
          notifiable: @friendship
        )
        flash[:notice] = 'Friend request is sent.'
        redirect_to user_path(@friend)
      else
        flash[:alert] = 'Unable to send friend request.'
        redirect_to user_path(@friend)
      end
    else
      flash[:alert] = 'An error has occured.'
      redirect_to user_path(@friend)
    end
  end

  def destroy
    if !@friendship.nil?
      @friendship.destroy
      flash[:notice] = 'Unfriended.'
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = 'An error has occured.'
      redirect_back(fallback_location: root_path)
    end
  end

  def update
    @friendship.accepted = true
    @friendship.save
    @user = User.find(@friendship.user_id)
    flash[:notice] = "You are now friends with #{@user.first_name}"
    redirect_to user_path(@user)
  end

  private

  def set_friendship
    @friend = User.find(params[:id])
    @friendship = current_user.get_friendship(@friend).first
  end
end
