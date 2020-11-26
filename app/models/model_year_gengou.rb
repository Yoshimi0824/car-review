class ModelYearGengou < ActiveHash::Base
  self.data = [
    { id: 0, name: '---' },
    { id: 1, name: '平成' },{ id: 2, name: '令和' }
  ]

  include ActiveHash::Associations
  has_many :reviews