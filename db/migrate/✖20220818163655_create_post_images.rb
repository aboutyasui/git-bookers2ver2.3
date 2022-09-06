class CreatePostImages < ActiveRecord::Migration[6.1]
  def change
    create_table :post_images do |t|
      #投稿画像を識別するIDは自動で作成されるため省略
      t.integer :user_id#投稿したユーザーを識別するID（users テーブルの id を保存する）
      t.string  :title#本のタイトル
      t.text :opinion#本の説明

      t.timestamps
    end
  end
end
