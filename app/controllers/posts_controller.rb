class PostsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      flash[:notice] = "Successfully posted."
    else
      flash[:alert] = "An error has occured."
    end

    redirect_back(fallback_location: root_path)
  end

  def destroy
    @post = Post.find(params[:id])

    if @post.destroy
      flash[:notice] = "Deleted post."
    else
      flash[:alert] = "An error has occured."
    end

    redirect_back(fallback_location: root_path)
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :parent_id, :body)
  end
end
