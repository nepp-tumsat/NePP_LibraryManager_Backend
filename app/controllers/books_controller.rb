# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :set_book, only: %i[show update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from ActiveRecord::RecordInvalid,  with: :render_unprocessable

  def index
    render json: Book.all, status: :ok
  end

  def show
    render json: @book, status: :ok
  end

  def create
    book = Book.create!(book_params)
    render json: book, status: :created, location: book_url(book)
  end

  def update
    @book.update!(book_params)
    render json: @book, status: :ok
  end

  def destroy
    @book.destroy!
    head :no_content
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(
      :title, :author, :description, :cover_image_url, :page_count, :price, :published_date
    )
  end

  # ---- error responders ----
  def render_not_found(err)
    render json: { errors: [{ code: 'not_found', detail: err.message }] }, status: :not_found
  end

  def render_unprocessable(err)
    render json: {
      errors: err.record.errors.map { |ve| { code: 'validation_error', attribute: ve.attribute, detail: ve.message } }
    }, status: :unprocessable_entity
  end
end
