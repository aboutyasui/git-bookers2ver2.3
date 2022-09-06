class UsersController < ApplicationController
  before_action :correct_user, only: [:edit]

  def index
   @user = current_user
   @users = User.all
   @book = Book.new
  end

  def show
   @user = User.find(params[:id])#1:N→user:books
   @books = @user.books#特定のユーザ（@user）に関連付けられた投稿全て（.books）を取得し@booksに渡す
   @book = Book.new
  end

  def edit
    @user = User.find(correct_user)
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] ="You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def correct_user
    @user = User.find(params[:id])
    if @user == current_user #ログイン中のユーザーの場合
      render :edit#編集ページに飛べる
    else
      redirect_to user_path(current_user)#自分のユーザーshowページに飛ぶ
    end
  end

end