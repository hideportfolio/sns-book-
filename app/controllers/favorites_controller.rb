# frozen_string_literal: true

class FavoritesController < ApplicationController
  def create
    @favorite = Book.find(params[:id]).favorites.new(user_id: current_user.id)
    @favorite.save
  end

  def destroy
    @favorite = current_user.favorites.find_by(book_id: params[:id])
    @favorite.destroy
  end
end
