require 'rails_helper'

RSpec.describe Address, type: :model do
  before do
    @address = FactoryBot.build(:address)
  end

  describe 'ユーザー登録機能(ウィザード形式２ページ目)' do
    context 'ユーザー登録がうまくいくとき' do
      it '全ての項目を入力すれば登録ができる' do
        expect(@address).to be_valid
      end
      it 'マンション名を入力しなくても登録できる' do
        @address.building_name = " "
        expect(@address).to be_valid
      end
    end
    context 'ユーザー登録がうまくいかないとき' do
      it '郵便番号が必須であること' do
        @address.postal_code = " "
        @address.valid?
        expect(@address.errors.full_messages).to include("郵便番号を入力してください")
      end
      it '郵便番号はハイフン(-)が必須であること' do
        @address.postal_code = "1234567"
        @address.valid?
        expect(@address.errors.full_messages).to include("郵便番号はハイフン(-)を入れてください")
      end
      it '都道府県が必須であること' do
        @address.prefecture_id = 0
        @address.valid?
        expect(@address.errors.full_messages).to include("都道府県を選択してください")
      end
      it '市町村が必須であること' do
        @address.municipality = " "
        @address.valid?
        expect(@address.errors.full_messages).to include("市町村を入力してください")
      end
      it '番地が必須であること' do
        @address.street_number = " "
        @address.valid?
        expect(@address.errors.full_messages).to include("番地を入力してください")
      end
    end
  end
end
