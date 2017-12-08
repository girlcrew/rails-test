# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!, only: %i[create edit update destroy]

  def index
    @comments = post.comments
  end

  def new
    @comment = post.comments.new
  end

  def create
    @comment = post.comments.create(comment_params)
    redirect_to @comment
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    @comment.update(comment_params)
    redirect_to @comment
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to root_path
  end

  private

  def post
    @post ||= Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:title, :content, :user_id)
          .merge(user_id: current_user.id)
  end
end
