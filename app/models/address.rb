class Address < ApplicationRecord

  belongs_to :user, optional: true

  with_options presence: true do
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'はハイフン(-)を入れてください' }
    validates :prefecture_id, numericality: { other_than: 0, message: 'を選択してください' }
    validates :municipality
    validates :street_number
  end

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture

end
