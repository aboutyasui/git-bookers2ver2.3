class UsersController < ApplicationController
  before_action :correct_user, only: [:edit]

  def index
   @user = current_user
   @users = User.all
   #@users = User.where.not(id: current_user.id)#current_user以外のすべてのuser.idを取得する
   @book = Book.new
  end

  #def followings#(youtubeより参照)
   #user = User.find(params[:id])#URLよりユーザー情報を取得
   #@users = user.followings#あるユーザー(user)をフォローしている人(followings)全員を取得する
  #end

  #def followers#(youtubeより参照)
    #user = User.find(params[:id])#URLよりユーザー情報を取得
    #@users = user.followers#あるユーザー(user)がフォローしている人(followers)全員を取得する
  #end

  def show
   @user = User.find(params[:id])#1:N→user:books

   @books = @user.books.page(params[:page]).reverse_order#特定のユーザ（@user）に関連付けられた投稿全て（.books）を取得し@booksに渡す
   #pageメソッド=kaminariを導入すると、モデルクラスにpageメソッドが定義される。
   #このメソッドは、ページネーションにおけるページ数を指定。
   #ビューのリクエストの際paramsの中にpageというキーが追加されて、その値がビューで指定したページ番号となる。よって、pageの引数はparams[:page]となる。
   #.reverse_order=「降順」に取得するメソッド

   @book = Book.new

   #昨日と前日、前日比の情報をviewに表示するための変数
   @today_book = @books.created_today
   @yesterday_book = @books.created_yesterday
   #bookモデルで定めたスコープの名前をここで使用しています。
   @this_week_book = @books.created_this_week
   @last_week_book = @books.created_last_week

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