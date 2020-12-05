require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー登録機能(ウィザード形式１ページ目)' do
    context 'ユーザー登録２ページ目へ進めるとき' do
      it '全ての項目を記入していれば進める' do
        expect(@user).to be_valid
        binding.pry
      end
    end
    context 'ユーザー登録２ページ目に進めないとき' do
      it 'ニックネームが必須であること' do
        @user.nickname = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end
      it 'ニックネームが一意性であること' do
        @user.save
        another_user = FactoryBot.build(:user, nickname: @user.nickname)
        another_user.valid?
        expect(another_user.errors.full_messages).to include("ニックネームはすでに存在します")
      end
      it 'メールアドレスが必須であること' do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("メールアドレスを入力してください")
      end
      it 'メールアドレスが一意性があること' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include("メールアドレスはすでに存在します")
      end
      it 'メールアドレスに＠が含まれること' do
        @user.email = "sample"
        @user.valid?
        expect(@user.errors.full_messages).to include("メールアドレスは不正な値です")
      end
      it 'パスワードが必須であること' do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include( "パスワードを入力してください")
      end
      it 'パスワードは６文字以上必須であること' do
        @user.password = "a1111"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは6文字以上で入力してください")
      end
      it 'パスワードが半角数字のみだと進めない' do
        @user.password = "111111"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードには英字と数字の両方を含めて設定してください")
      end
      it 'パスワードが半角英字のみだと進めない' do
        @user.password = "aaaaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードには英字と数字の両方を含めて設定してください")
      end
      it 'パスワードは確認用を含めて２回入力すること' do
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
      it 'パスワードとパスワード確認用の値が同じであること' do
        @user.password = "a11111"
        @user.password_confirmation = "b22222"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
      it '電話番号は必須であること' do
        @user.phone_number = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("電話番号を入力してください")
      end
      it '電話番号は11ケタ以内であること' do
        @user.phone_number = "090123456789"
        @user.valid?
        expect(@user.errors.full_messages).to include("電話番号は11文字以内で入力してください")
      end
      it '電話番号は数字のみ(ハイフン不要)であること' do
        @user.phone_number = "090-1234-5678"
        @user.valid?
        expect(@user.errors.full_messages).to include("電話番号にはハイフン(-)を入れないでください")
      end
      it '生年月日が必須であること' do
        @user.birthday = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("生年月日を入力してください")
      end
    end
  end
end
