class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # 認証トークンはユニークに。ただしnilは許可
  validates :authentication_token, uniqueness: true, allow_nil: true
  has_many :rooms
  has_many :comments

   # 認証トークンが無い場合は作成
  def ensure_authentication_token
    self.authentication_token || generate_authentication_token
  end

   # 認証トークンの作成
  def generate_authentication_token
    loop do
      old_token = self.authentication_token
      token = SecureRandom.urlsafe_base64(24).tr('lIO0', 'sxyz')
    break token if (self.update!(authentication_token: token) rescue false) && old_token != token
    end
  end

  def delete_authentication_token
    self.update(authentication_token: nil)
  end
end
