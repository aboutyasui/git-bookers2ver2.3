class BookCommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    comment = current_user.book_comments.new(book_comment_params)
    #↑の書き方は以下のように記述したものと変わりません。
    #comment = BookComment.new(book_comment_params)
    #comment.user_id = current_user.id

    comment.book_id = @book.id
    comment.save
    #redirect_to book_path(book) #redirect_to request.referer でもOK
  end

  def destroy #destoryアクションを作成(コメントの削除が可能)
    @book = Book.find(params[:book_id])
    BookComment.find(params[:id]).destroy
    #redirect_to book_path(params[:book_id]) #redirect_to request.referer でもOK
  end

  private
  #commentのストロングパラメータ
  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
