class Automaker < ActiveHash::Base
  self.data = [
    { id: 0, name: '---' },
    { id: 1, name: 'トヨタ' }, { id: 2, name: 'レクサス' }, { id: 3, name: 'ホンダ' },
    { id: 4, name: 'スズキ' }, { id: 5, name: '日産' }, { id: 6, name: 'スバル' },
    { id: 7, name: '三菱' }, { id: 8, name: 'ダイハツ' }, { id: 9, name: 'その他国産' },
    { id: 10, name: '輸入車' }
  ]

  include ActiveHash::Associations
  has_many :reviews
end