class RelationshipsController < ApplicationController
  before_action :set_user, only: [:followings, :followers]
  #before_action :authenticate_user!#ユーザがログインしているかどうかを確認し、ログインしていない場合はユーザをログインページにリダイレクトする。followings

  def create
    current_user.follow(params[:user_id])
    redirect_to request.referer#元のページに遷移
  end

  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end

  def followings
    @users = @user.followings
  end

  def followers
    @users = @user.followers
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

#youtubeより参照
  #def create
    #following = current_user.relationships.build(follower_id: params[:user_id])
    #1,カレントユーザーに紐づいたrelationshipを作成する→フォローする側のカラム(following)にカレントユーザーのIDを格納
    #2,フォローされた側のカラム(follower_id)にURL状のユーザーID(params[:user_id])が格納される
    #following.save
    #redirect_to request.referer || root_path  #元のviewに戻る・・・失敗した場合はroot_pathへ
  #end

  #def destroy
    #following = currenr_user.relationships.find_by(follower_id: params[user_id])
    #1,カレントユーザーに紐づいたrelationshipsを持ってくる( currenr_user.relationships )
    #2,フォローを解除しようとしている対象のID( find_by(follower_id: params[user_id]) )の情報を持ってくる( .find_by  )

    #following.destroy
    #redirect_to request.referer || root_path #元のviewに戻ってきます。
  #end

end
