class UsersController < ApplicationController
before_action :authenticate_user!
protect_from_forgery


  def new
        @book = Book.new
  end

  def show
    @book =Book.new
    @user = User.find(params[:id])
    @books = @user.books
    @users = User.all

  end

  def create
        @user = User.new(user_params)
        if @user.save
         redirect_to  user_path(current_user.id)
        else
         render "users/sign_up"
        end
  end

  def edit
    @user=User.find(params[:id])


  end

  def index
      @users =User.all
    	@books = Book.all
    	@book_new = Book.new
      @user = current_user
  end



def update
    @user=User.find(params[:id])


    if @user.update(user_params)
       flash[:notice] = "You have updated user successfully."
     redirect_to user_path(current_user.id)
    else
      flash[:notice] = " errors prohibited this obj from being saved:"
     render :edit
    # redirect_to user_path(@user)
    end

end

private

def user_params
    params.require(:user).permit(:name ,:profile_image ,:introduction)
end

def correct_user
      @user = User.find(params[:id])
      if current_user != @user
       redirect_to user_path(@user)
      end
end


end
