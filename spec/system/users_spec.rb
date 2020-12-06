require 'rails_helper'

RSpec.describe "ユーザー新規登録", type: :system do
  before do
    @user = FactoryBot.build(:user)
    @address = FactoryBot.build(:address)
  end

  context 'ユーザー新規登録ができるとき' do
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      # トップページに移動する
        visit root_path
      # トップページに新規登録ページ(ウィザード形式１ページ目)へ遷移するボタンがあることを確認する
        expect(page).to have_content('新規登録')
      # 新規登録ページ(ウィザード形式１ページ目)へ移動する
        visit new_user_registration_path
      # ユーザー情報を入力する
        fill_in 'ニックネーム', with: @user.nickname
        fill_in 'メールアドレス', with: @user.email
        fill_in 'パスワード', with: @user.password
        fill_in 'パスワード確認用', with: @user.password
        fill_in '電話番号', with: @user.phone_number
        select '1930', from: 'user[birthday(1i)]'
        select '1', from: 'user[birthday(2i)]'
        select '1', from: 'user[birthday(3i)]'
      # Nextボタンと押すと住所入力ページ(ウィザード形式2ページ目)へ移動する
        click_button 'Next'
      # 住所情報を入力する
        fill_in '郵便番号', with: @address.postal_code
        select "#{@address.prefecture.name}", from: 'address[prefecture_id]'
        fill_in '市区町村', with: @address.municipality
        fill_in '番地', with: @address.street_number
      # 登録ボタンを押すとユーザーモデルのカウントが１上がることを確認する
        expect{
          find('input[name="commit"]').click
        }.to change { User.count }.by(1)
      # トップページへ遷移する
        expect(current_path).to eq root_path
      # ログアウトボタンと新規投稿ボタンが表示されていることを確認する
        expect(page).to have_content('ログアウト')
        expect(page).to have_content('新規投稿')
      # 新規登録ボタンやログインボタンが表示されていないことを確認する
        expect(page).to have_no_content('新規登録')
        expect(page).to have_no_content('ログイン')
    end
  end

  context 'ユーザー新規登録ができないとき' do
    it '誤った情報ではユーザー新規登録が出来ずに新規登録ページへ戻ってくる(ウィザード形式１ページ目)' do
      # トップページに移動する
        visit root_path
      # トップページに新規登録ページ(ウィザード形式１ページ目)へ遷移するボタンがあることを確認する
        expect(page).to have_content('新規登録')
      # 新規登録ページ(ウィザード形式１ページ目)へ移動する
        visit new_user_registration_path
      # ユーザー情報を入力する
        fill_in 'ニックネーム', with: ""
        fill_in 'メールアドレス', with: ""
        fill_in 'パスワード', with: ""
        fill_in 'パスワード確認用', with: ""
        fill_in '電話番号', with: ""
      # Nextボタンを押しても住所入力ページへ遷移せず新規登録ページへ戻される
        expect(current_path).to eq "/users/sign_up"
    end

    it '誤った住所ではユーザー新規登録が出来ずに住所入力ページへ戻ってくる(ウィザード形式2ページ目)' do
      # トップページに移動する
        visit root_path
      # トップページに新規登録ページ(ウィザード形式１ページ目)へ遷移するボタンがあることを確認する
        expect(page).to have_content('新規登録')
      # 新規登録ページ(ウィザード形式１ページ目)へ移動する
        visit new_user_registration_path
      # ユーザー情報を入力する
        fill_in 'ニックネーム', with: @user.nickname
        fill_in 'メールアドレス', with: @user.email
        fill_in 'パスワード', with: @user.password
        fill_in 'パスワード確認用', with: @user.password
        fill_in '電話番号', with: @user.phone_number
        select '1930', from: 'user[birthday(1i)]'
        select '1', from: 'user[birthday(2i)]'
        select '1', from: 'user[birthday(3i)]'
      # Nextボタンと押すと住所入力ページ(ウィザード形式2ページ目)へ移動する
        click_button 'Next'
      # 住所情報を入力する
        fill_in '郵便番号', with: ""
        select "---", from: 'address[prefecture_id]'
        fill_in '市区町村', with: ""
        fill_in '番地', with: ""
      # 登録ボタンを押してもユーザーモデルのカウントは上がらないことを確認する
        expect{
          find('input[name="commit"]').click
        }.to change { User.count }.by(0)
      # 住所入力ページへ戻されることを確認する
        expect(current_path).to eq "/addresses"
    end
  end
end

RSpec.describe 'ログイン', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end

  context 'ログインできるとき' do
    it '保存されているユーザーの情報と合致すればログインができる' do
      # トップページに移動する
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログイン')
      # ログインページへ遷移する
      visit new_user_session_path
      # 正しいユーザー情報を入力する
      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: @user.password
      # ログインボタンを押す
      find('input[name="commit"]').click
      # トップページへ遷移することを確認する
      expect(current_path).to eq root_path
    end
  end

  context 'ログインできないとき' do
    it '保存されているユーザーの情報と合致しないとログインができない' do
      # トップページに移動する
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログイン')
      # ログインページへ遷移する
      visit new_user_session_path
      # ユーザー情報を入力する
      fill_in 'user[email]', with: ""
      fill_in 'user[password]', with: ""
      # ログインボタンを押す
      find('input[name="commit"]').click
      # ログインページへ戻されることを確認する
      expect(current_path).to eq new_user_session_path
    end
  end

end
