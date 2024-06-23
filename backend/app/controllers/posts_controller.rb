# frozen_string_literal: true

# PostsController はユーザーの投稿を扱うコントローラーです。
class PostsController < ApplicationController
  before_action :set_user
  before_action :set_post, only: %i[show update destroy]

  # GET /users/:user_id/posts
  def index
    @posts = @user.posts

    render json: @posts
  end

  # GET /users/:user_id/posts/:id
  def show
    render json: @post
  end

  # POST /users/:user_id/posts
  def create
    @post = @user.posts.build(post_params)

    if @post.save
      render json: @post, status: :created, location: user_post_url(@user, @post)
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/:user_id/posts/:id
  def update
    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/:user_id/posts/:id
  def destroy
    @post.destroy!
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:content)
  end
end
