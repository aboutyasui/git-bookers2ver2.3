class BooksController < ApplicationController
 before_action :authenticate_user! #ユーザがログインしているかどうかを確認し、ログインしていない場合はユーザをログインページにリダイレクトする。
 before_action :correct_user, only: [:edit, :update, :destroy]

   # 投稿データの保存
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id#この投稿の user_id としてcurrent_user.id(ログイン中のユーザーのID) の値を代入する、という意味
    if @book.save #対象のカラム（ここではtitleとopinion）にデータが保存されること
     flash[:notice] ="You have created book successfully."
     redirect_to book_path(@book) #投稿に成功後showに戻る
    else
     @user = current_user
     @books = Book.all
     render :index #投稿に失敗後新規投稿画面が表示される
    end

  end

  def index
   @user = current_user
   @books = Book.all
   @book = Book.new
   @book_comments = BookComment.all#コメントを一覧ページに表示するためのインスタンス変数を定義する
   
   #@books.each do |book|
   # pp favorite_btn
   # end
  end

  def show
   @book = Book.find(params[:id])#アクション内にparams[:id]と記述することで、詳細画面で呼び出される投稿データを URLの/posts/:id 内の:idで判別可能にする。
   @user = @book.user#特定のbook（@book）に関連付けられた投稿全て（.user）を取得し@userに渡す
   @books = Book.new
   @book_comment = BookComment.new
   #@post_comment = PostComment.new(meshiteroo_appでの書き方を参照)
   #コメントを投稿するためのインスタンス変数を定義する
  end

  def edit
   @book = Book.find(params[:id])
  end

  def update
   @book =  Book.find(params[:id]) #更新するBookレコードを取得
    if @book.update(book_params)#更新処理を分岐→条件：うまくupdateできるか否か
      redirect_to book_path(@book.id), notice: "You have updated book successfully."#その本のshowページへ戻る&フラッシュメッセージを取得
    else
      render :edit#編集ページに戻る
    end
  end

  def destroy
   @book =  Book.find(params[:id]) #削除するBookレコードを取得
   @book.destroy #削除する処理
   redirect_to books_path #booksのindexページへ戻る
  end

  # 投稿データのストロングパラメータ
  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def correct_user #edit & destroy で使う
    @book = Book.find(params[:id])#その本の情報を取得
    @user = @book.user
    redirect_to(books_path) unless @user == current_user#
  end

end
