class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
  end

  def edit
  end

  def update

  end

  def index
  end

  private
  def post_params
    params.require(:post).permit(:title, :sub_id, :url, :content)
  end

end
