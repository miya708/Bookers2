class BooksController < ApplicationController
  protect_from_forgery
  before_action :authenticate_user!
  before_action :current_user,only: [:edit, :update, :destroy]

  def new
    @book = Book.new
  end


 def create
    @books = Book.all
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: 'You have created book successfully.'
    else
      render :index
    end
 end


  def index
    @books = Book.all
    @book = Book.new
    @user = current_user


  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @book_new = Book.new

  end

  def edit
    @book = Book.find(params[:id])

  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path

  end

  def update
    @book = Book.find(params[:id])
    @book.update(book_params)
    if @book.save
      redirect_to book_path(@book), notice: 'You have updated book successfully.'
    else
      render :edit
    end
  end


  private

  def book_params
    params.require(:book).permit(:title, :body)
  end


end
