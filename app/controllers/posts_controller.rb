class PostsController < ApplicationController
  before_action :set_post, only: [:show]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.front_page_posts
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end  
end
