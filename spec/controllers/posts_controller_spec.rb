# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe 'GET /new ' do
    it 'responds with 200' do
      get :new
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /' do
    it 'responds with 200' do
      post :create, params: { post: { message: 'Hello, world!' } }
      expect(response).to redirect_to(posts_url)
    end

    it 'creates a post' do
      post :create, params: { post: { message: 'Hello, world!' } }
      expect(Post.find_by(message: 'Hello, world!')).not_to be nil
    end

    it 'destroys a post' do
      post :create, params: { post: { message: 'Hello, world!' } }
      mypost = Post.find_by(message: 'Hello, world!')
      destroyed_post = Post.find(mypost.id)
      destroyed_post.destroy
      expect(Post.find_by(message: 'Hello, world!')).to be nil
    end

    it 'updates a post' do
      post :create, params: { post: { message: 'Hello, world!' } }
      mypost = Post.find_by(message: 'Hello, world!')
      edit_post = Post.find(mypost.id)
      edit_post.update(message: 'Hello!')
      expect(edit_post.message).not_to be("Hello, world!")
    end
  end

  describe 'GET /' do
    it 'responds with 200' do
      get :index
      expect(response).to have_http_status(200)
    end
  end
end
