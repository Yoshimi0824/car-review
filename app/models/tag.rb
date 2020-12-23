class Tag < ApplicationRecord
  has_many :reviews_tag_relations
  has_many :reviews, through: :review_tag_relations
end
