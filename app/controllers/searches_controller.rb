class SearchesController < ApplicationController
  before_action :authenticate_user!

  #下記コードにて検索フォームからの情報を受け取っています。
  #検索モデル→params[:modle]
  #検索方法→params[:content]
  #検索ワード→params[:method]
  def search
    #以下サンプルより
    @model = params[:model]
		@content = params[:content]
		@method = params[:method]
		if @model == 'user'
			@records = User.search_for(@content, @method)
		else
			@records = Book.search_for(@content, @method)
		end

    #@model = params[:model]

   # if @model == "User" #if文を使い、検索モデルUser or Bookで条件分岐させます。
     # @records = User.search_for(@content, @method)
     # @recodes = User.looks(params[:content], params[:method])　←　別の書き方Ver
   # else
    # @records = Book.search_for(@content, @method)
      #検索方法params[:content]と、検索ワードparams[:method]を参照してデータを検索し、
      #1：インスタンス変数@recodesにUserモデル内での検索結果を代入します。
      #2：インスタンス変数@recodesにBookモデル内での検索結果を代入します。
   # end

  end

end
