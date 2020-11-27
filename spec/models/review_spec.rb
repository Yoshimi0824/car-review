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
      it 'メーカーが必須であること'　do
        @review.automaker_id = 0
        @review.valid?
        expect(@review.errors.full_messages).to include()
    end
  end
end
