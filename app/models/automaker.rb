class ModelYearGengou < ActiveHash::Base
  self.data = [
    { id: 0, name: '---' },

  ]

  include ActiveHash::Associations
  has_many :reviews