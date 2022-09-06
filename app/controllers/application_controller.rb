class ApplicationController < ActionController::Base
   before_action :authenticate_user!,except: [:top,:about ]#ログインしていない状態でトップページ以外のアクセスされた場合は、ログイン画面へリダイレクトする
   #before_actionメソッドは、このコントローラが動作する前に実行されます
   #authenticate_userメソッドは、 :authenticate_user!とすることによって、「ログイン認証されていなければ、ログイン画面へリダイレクトする」機能を実装できます。
   #exceptは指定したアクションをbefore_actionの対象から外します。 Meshiterroではトップページのみログイン状態に関わらず、アクセス可能とするためにtopアクションを指定しています。

   before_action :configure_permitted_parameters, if: :devise_controller?
   #devise利用の機能（ユーザ登録、ログイン認証など）が使われる前に
   #configure_permitted_parametersメソッドが実行されます。

   def after_sign_in_path_for(resource)#サインイン後にどこに遷移するかを設定しているメソッド
    user_path(current_user) #ユーザーページに遷移
   end

   def after_sign_out_path_for(resource)#サインアウト後にどこに遷移するかを設定するメソッド
    root_path #トップページに遷移
   end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
  #configure_permitted_parametersメソッドでは、devise_parameter_sanitizer.permitメソッドを使うことで
  #ユーザー登録(sign_up)の際に、ユーザー名(name)のデータ操作を許可しています。

end
