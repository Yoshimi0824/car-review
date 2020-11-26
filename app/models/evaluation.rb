class Evaluation < ActiveHash::Base
  self.data = [
    { id: 0, name: '---' },
    { id: 1, name: '１点' }, { id: 2, name: '２点' },
    { id: 3, name: '３点' }, { id: 4, name: '４点' }, { id: 5, name: '５点' }
  ]

  include ActiveHash::Associations
  has_many :reviews
end