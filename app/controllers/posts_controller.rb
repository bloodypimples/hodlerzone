class PostsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = current_user.posts.build(post_params)

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
    params.require(:post).permit(:user_id, :post_id, :body)
  end
end
