class EraName < ActiveHash::Base
  self.data = [
    { id: 0, name: '---' },
    { id: 1, name: '昭和' },{ id: 2, name: '平成' },{ id: 3, name: '令和' },
    { id: 4, name: '不明' }
  ]

  include ActiveHash::Associations
  has_many :reviews
end