# frozen_string_literal: true

class BooksController < ApplicationController
  def index
    books = Book.all
    render json: books, status: :ok
  end

  def show
    book = Book.find(params[:id])
    render json: book, status: :ok
  end

  def create
    book = Book.new(book_params)
    if book.save
      render json: book, status: :created
    else
      render json: book.errors, status: :unprocessable_entity
    end
  end

  def update
    book = Book.find(params[:id])
    if book.update(book_params)
      render json: book, status: :ok
    else
      render json: book.errors, status: :unprocessable_entity
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :description, :cover_image_url, :page_count, :price, :published_date)
  end
end
