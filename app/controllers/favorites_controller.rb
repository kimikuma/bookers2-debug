class FavoritesController < ApplicationController

  def create
    book=Book.find(params[:book_id])
    favorite=current_user.favorites.new(book_id:book.id)
    favorite.save
     if request.path == books_path
      redirect_back(fallback_location: books_path) and return
     else
       redirect_back(fallback_location: book_path(book)) and return
     end
  end

  def destroy
    book=Book.find(params[:book_id])
    favorite=current_user.favorites.find_by(book_id:book.id)
    favorite.destroy
    if request.path == books_path
      redirect_back(fallback_location: books_path) and return
    else
       redirect_back(fallback_location: book_path(book)) and return
    end
  end
end
