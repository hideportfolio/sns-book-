# frozen_string_literal: true

class BookCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    comment = Book.find(params[:id]).book_comments.new(book_comment_params)
    comment.user_id = current_user.id
    comment.save
    @comments = Book.find(params[:id]).book_comments
  end

  def destroy
    comment = BookComment.find(params[:id])
    book = comment.book
    comment.destroy if comment.user == current_user
    @comments = book.book_comments
    # redirect_to request.referer
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
