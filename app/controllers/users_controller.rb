class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @friends = @user.get_all_friends
    @friend_groups = @friends.in_groups_of(3)
    @posts = @user.posts.where(post_id: nil).order("created_at desc")
  end
end
