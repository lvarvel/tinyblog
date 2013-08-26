require 'spec_helper'

describe PostsController do
  describe "GET index" do
    it "assigns all posts as @posts" do
      posts = Post.all
      get :index, {}
      assigns(:posts).should eq(posts)
    end
  end

  describe "GET show" do
    it "assigns the requested post as @post" do
      post = posts(:intro_to_object_oriented_intercal)
      get :show, {:id => post.to_param}
      assigns(:post).should eq(post)
    end
  end
end
