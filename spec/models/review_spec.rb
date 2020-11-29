require 'rails_helper'

RSpec.describe Review, type: :model do
  before do
    @review = FactoryBot.build(:review)
  end

  describe '記事投稿機能' do
    context '投稿がうまくいくとき' do
      it '全ての項目を記入すると投稿できる' do
        expect(@review).to be_valid
      end
      it '画像を付けなくても投稿できる' do
        @review.image = ""
        expect(@review).to be_valid
      end
    end

    context '投稿がうまくいかないとき' do
      it 'メーカーが必須であること' do
        @review.automaker_id = 0
        @review.valid?
        expect(@review.errors.full_messages).to include("メーカーを選択してください")
      end
      it '車種が必須であること' do
        @review.model_of_car = ""
        @review.valid?
        expect(@review.errors.full_messages).to include("車種を入力してください")
      end
      it 'グレードが必須であること' do
        @review.grade = ""
        @review.valid?
        expect(@review.errors.full_messages).to include("グレードを入力してください")
      end
      it '年式(元号)が必須であること' do
        @review.era_name_id = 0
        @review.valid?
        expect(@review.errors.full_messages).to include("年式(元号)を選択してください")
      end
      it '年式が必須であること' do
        @review.model_year = ""
        @review.valid?
        expect(@review.errors.full_messages).to include("年式を入力してください")
      end
      it '年式は半角数字での入力が必須であること' do
        @review.model_year = "２２"
        @review.valid?
        expect(@review.errors.full_messages).to include("年式は半角数字で入力してください")
      end
      it '年式は3桁では登録できないこと' do
        @review.model_year = "222"
        @review.valid?
        expect(@review.errors.full_messages).to include("年式の最大文字数は２ケタです")
      end
      it 'デザインが必須であること' do
        @review.design_id = 0
        @review.valid?
        expect(@review.errors.full_messages).to include("デザインを選択してください")
      end
      it '走行性能が必須であること' do
        @review.driving_performance_id = 0
        @review.valid?
        expect(@review.errors.full_messages).to include("走行性能を選択してください")
      end
      it '乗り心地が必須であること' do
        @review.ride_comfort_id = 0
        @review.valid?
        expect(@review.errors.full_messages).to include("乗り心地を選択してください")
      end
      it '積載性が必須であること' do
        @review.lording_id = 0
        @review.valid?
        expect(@review.errors.full_messages).to include("積載性を選択してください")
      end
      it '燃費が必須であること' do
        @review.fuel_economy_id = 0
        @review.valid?
        expect(@review.errors.full_messages).to include("燃費を選択してください")
      end
      it '価格が必須であること' do
        @review.price_id = 0
        @review.valid?
        expect(@review.errors.full_messages).to include("価格を選択してください")
      end
      it '良い点が必須であること' do
        @review.good_point = ""
        @review.valid?
        expect(@review.errors.full_messages).to include("良い点を入力してください")
      end
      it '悪い点が必須であること' do
        @review.bad_point = ""
        @review.valid?
        expect(@review.errors.full_messages).to include("悪い点を入力してください")
      end
    end
  end
end
