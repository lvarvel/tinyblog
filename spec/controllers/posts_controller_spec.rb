require 'spec_helper'

describe PostsController do
  describe "GET index" do
    it "assigns gets the front page posts as @posts" do
      posts = double(:posts)
      Post.stub(:front_page_posts).and_return(posts)
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
