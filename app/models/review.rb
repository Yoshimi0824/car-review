class Review < ApplicationRecord

  acts_as_taggable
  
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_one_attached :image
  

  
  with_options presence: true do
    validates :model_of_car
    validates :grade
    validates :model_year, format: { with: /\A[0-9]+\z/, message: 'は半角数字で入力してください' },
                           length: { maximum: 2, message: 'の最大文字数は２ケタです' },
                           numericality: { only_integer: true, message: 'は半角数字で入力してください' }
    validates :good_point
    validates :bad_point
    
    
    with_options numericality: { other_than: 0, message: 'を選択してください' } do
      validates :automaker_id
      validates :era_name_id
      validates :design_id
      validates :driving_performance_id
      validates :ride_comfort_id
      validates :lording_id
      validates :fuel_economy_id
      validates :price_id
    end
  end

  

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :automaker
  belongs_to :evaluation
  belongs_to :era_name
  

  def like_user(user_id)
    likes.find_by(user_id: user_id)
  end

end
