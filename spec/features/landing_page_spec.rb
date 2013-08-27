require 'spec_helper'

describe 'The landing page', :js do
  let(:post) { posts(:intro_to_object_oriented_intercal) }
  let(:author) { post.author }

  it 'shows the most recent post on the landing page' do
    visit '/'
    page.should have_content post.title
    page.should have_content author.name
    page.should have_content post.body
  end
end
