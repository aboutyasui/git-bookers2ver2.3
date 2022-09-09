class AddImpressionsCountToBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :impressions_count, :integer, default: 0#指定したテーブルにカラムを追加
    #add_column(テーブル名 カラム名, タイプ, オプション引数)
    #タイプ「integer」→整数型（４バイト）
    #オプション「default」→デフォルト値を指定
  end
end
