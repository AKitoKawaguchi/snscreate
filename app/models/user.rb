class User < ApplicationRecord
  self.primary_key = "id"
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy
  has_many :trainrecodes , class_name: "Trainrecode", foreign_key: "user_id", dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  validates :name, {presence: true}
  before_save { self.email = email.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, {presence: true, uniqueness: {case_sensitive: false}, format: {with: VALID_EMAIL_REGEX, message: "形式が正しくありません"}}
  VALID_PASSWORD_REGEX =/\A(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[\d])\w{6,12}\z/
  validates :password, {presence: true, format: {with: VALID_PASSWORD_REGEX, message: "半角6~12文字英大文字・小文字・数字それぞれ１文字以上含む必要があります"}}

  def posts
    return Post.where(user_id: self.id)
  end
end
