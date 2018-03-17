class PostsController < ApplicationController
  before_action :authenticate_user!

  def create
    if params[:post][:receiver_id]
      # create external post
      @user = User.find(params[:post][:receiver_id])

      if current_user.is_friends_with?(@user)
        @post = @user.posts.build(post_params)
        @post.poster_id = current_user.id
      else
        @post = current_user.posts.build(post_params)
      end
    else
      # create internal post
      @post = current_user.posts.build(post_params)
    end

    if @post.save
      flash[:notice] = "Successfully posted."
    else
      flash[:alert] = "An error has occured."
    end

    respond_to do |format|
      format.js {
        flash[:notice] = nil
        flash[:alert] = nil
      }
      format.html {
        redirect_back(fallback_location: root_path)
      }
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])

    if @post.destroy
      flash[:notice] = "Deleted post."
    else
      flash[:alert] = "An error has occured."
    end

    redirect_back(fallback_location: root_path)
  end

  def downvote
    @post = Post.find(params[:id])
    @post.downvote_by current_user

    respond_to do |format|
      format.js
    end
  end

  def upvote
    @post = Post.find(params[:id])
    @post.upvote_by current_user

    respond_to do |format|
      format.js
    end
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :post_id, :body, :poster_id)
  end
end
