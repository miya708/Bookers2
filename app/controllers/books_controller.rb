class BooksController < ApplicationController
  before_action :correct_user, only: [:edit, :update]
  before_action :set_book


  def new
    @book = Book.new
  end
  
  def set_book
    @book = current_user.books.find_by(id: params[:id])
  end


 def create
    @books = Book.all
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "you have created book successfully."
      redirect_to book_path(@book.id)
    else
      @user = current_user
  
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
    if @book.user == current_user
            render "edit"
    else
            redirect_to books_path
    end

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
      flash[:notice] = "you have created book successfully."
      redirect_to book_path(@book)
    else
      render :edit
    end
  end


  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
  
  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    redirect_to(books_path) unless @user == current_user
  end
  

end
