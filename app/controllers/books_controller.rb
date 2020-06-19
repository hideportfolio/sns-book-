# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :authenticate_user!
  def show
    @books = Book.find(params[:id])
    @user = current_user
    @book = Book.new
    @book_comments = @books.book_comments
    @book_comment = BookComment.new
  end

  def index
    @books = Book.all
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id), notice: 'successfully created book!'
    else
      @books = Book.all
      @user = current_user
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
    redirect_to books_path unless @book.user_id.to_i == current_user.id
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to @book, notice: 'successfully updated book!'
    else
      render 'edit'
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path, notice: 'successfully delete book!'
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
