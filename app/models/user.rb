class User < ApplicationRecord
 
  has_one :address
  has_many :reviews
  has_many :comments
  has_many :likes
  has_many :sns_credentials

  with_options presence: true do
    validates :nickname, uniqueness: { case_sensitive: true }
    validates :birthday
    validates :phone_number, format: { with: /\A[0-9]+\z/, message: 'にはハイフン(-)を入れないでください' },
                             length: { maximum: 11 }
  end

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'には英字と数字の両方を含めて設定してください'

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

         
  def self.from_omniauth(auth)
    sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create
    user = User.where(email: auth.info.email).first_or_initialize(
     nickname: auth.info.name,
       email: auth.info.email
   )
   # userが登録済みであるか判断
    if user.persisted?
      sns.user = user
      sns.save
    end
    user
  end

end
