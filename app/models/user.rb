class User < ApplicationRecord
 
  has_one :address
  has_many :reviews
  has_many :comments

  with_options presence: true do
    validates :nickname
    validates :birthday
    validates :phone_number, format: { with: /\A[0-9]+\z/, message: 'にはハイフン(-)を入れないでください' },
                             length: { maximum: 11 }
  end

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'には英字と数字の両方を含めて設定してください'

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
