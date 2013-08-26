require 'spec_helper'

describe Post do
  describe 'before filters' do
    it 'publishes the post before saving if published is true' do
    end
  end
  describe '#publish' do
    let(:post) { build(:post, published: true, published_at: '') }

    around do |example|
      Timecop.freeze
      post.stub(:save)
      example.call
      Timecop.return
    end

    it 'sets published_at to the current time' do
      post.publish
      post.published_at.should == Time.now
    end

    it 'saves the post' do
      post.should receive(:save)
      post.publish
    end

    context 'when the post has already been published' do
      let(:post) { build(:post, published: true, published_at: Time.now) }
      it 'does nothing' do
        post.publish
        post.should_not receive(:save)
        post.published_at.should == Time.now
      end
    end 

    context 'when the post has been published and then unpublished' do
      let(:pubdate) { Time.now - 1.day }
      let(:post) { build(:post, published: false, published_at: pubdate) }

      it 'leaves the published_at date alone' do
        post.publish
        post.published_at.should == pubdate
      end
    end
  end

  describe '.front_page_posts' do
    it 'should return all the published posts' do
      published_count = Post.where(published: true).count
      Post.front_page_posts.length.should == published_count
    end

    it 'orders the posts in reverse chronological order of publication' do
      Post.delete_all

      create(:post, title: 'First Post', published_at: Time.now)
      create(:post, title: 'Second Post', published_at: Time.now + 1.day)

      posts = Post.front_page_posts

      posts.first.title.should == 'Second Post'
      posts.second.title.should == 'First Post'
    end

    it 'only shows published posts' do
      Post.delete_all

      create(:post, title: 'Published Post', published: true)
      create(:post, title: 'Draft Post', published: false)

      posts = Post.front_page_posts
      posts.length.should == 1
      posts.first.title.should == 'Published Post'
    end
  end
end
