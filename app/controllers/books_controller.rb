class BooksController < ApplicationController
  def show
    unless @book = current_book
      render status: :not_found, json: 'not found'
    end
  end

  private

  def current_book
    @current_book ||= AozoraLibrary.books.sample
  end
end
