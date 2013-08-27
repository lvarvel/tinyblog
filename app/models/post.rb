class Post < ActiveRecord::Base
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'

  def self.front_page_posts
    posts = Post.order('published_at DESC').where(published: true)
  end

  def publish
    if self.published && self.published_at.blank?
      self.published_at = Time.now 
    end
    self.save
  end
end
