class Book < ApplicationRecord
  #has_one_attached :book#本の情報を保存するメソッド
  belongs_to :user##1:N の「N」側にあたるモデルに、belongs_to を記載する必要がある
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  has_many :view_counts, dependent: :destroy
  
  #scope :スコープの名前, -> { 条件式 }
  scope :created_today, -> { where(created_at: Time.zone.now.all_day) } # 今日
  scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) } # 前日
  scope :created_this_week, -> { where(created_at: 6.day.ago.beginning_of_day..Time.zone.now.end_of_day) } 
  scope :created_last_week, -> { where(created_at: 2.week.ago.beginning_of_day..1.week.ago.end_of_day) } 

  is_impressionable counter_cache: true
  #is_impressionable → Bookモデルでimpressionistを使用できるようにします。
  #counter_cache: true → impressions_countカラムがupdateされるようにします。

  #バリデーション
   validates :title,presence: true
   validates :body, length: { maximum: 200 },presence: true
   #validatesでは対象となる項目を指定し、入力されたデータのpresence(存在)をチェックする
   #trueと書くとデータが存在しなければならないという設定になる
  def favorited_by?(user)#このメソッドで、引数で渡されたユーザidがFavoritesテーブル内に存在（exists?）するかどうかを調べます。
    favorites.exists?(user_id: user.id)
  end

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
      #画像が設定されない場合はapp/assets/imagesに格納されているno_image.jpgという画像をデフォルト画像としてActiveStorageに格納
    end
    image
  end
def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/sample-author1.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed#画像を縦横共に100pxのサイズに変換する
end
end
