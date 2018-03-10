class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @friends = @user.get_all_friends
    @friend_groups = @friends.in_groups_of(3)
  end
end
