class UserRoom < ApplicationRecord
   belongs_to :user #user_roomsテーブルはusersテーブルとroomsテーブルの中間テーブルです。
   belongs_to :room
end
