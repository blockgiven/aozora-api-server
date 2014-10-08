class SentencesController < ApplicationController
  def show
    unless @sentence = current_sentence
      render status: :not_found, text: 'not found'
    end
  end

  private

  def current_book
    @current_book ||= AozoraLibrary.books.sample
  end

  def current_sentence
    @current_sentence ||= current_book.try(:first)
  end
end
