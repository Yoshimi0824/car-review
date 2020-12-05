require 'rails_helper'

RSpec.describe "ユーザー新規登録", type: :system do
  before do
    @user = rails g rspec:system users
  end

  context 'ユーザー新規登録ができるとき' do
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する'　do
      # トップページに移動する
        visit root_path
      # トップページに新規登録ページ(ウィザード形式１ページ目)へ遷移するボタンがあることを確認する
        expect(page).to have_content('新規登録')
      # 新規登録ページ(ウィザード形式１ページ目)へ移動する
        visit new_user_session_path
      # ユーザー情報を入力する
        fill_in ''
        fill_in
        fill_in
        fill_in
        fill_in
        fill_in
      # 次へボタンと押すと住所入力ページへ移動する
      # 住所情報を入力する
      # 登録ボタンを押すとユーザーモデルのカウントが１上がることを確認する
      # トップページへ遷移する
      # ログアウトボタンと新規投稿ボタンが表示されていることを確認する
      # 新規登録ボタンやログインボタンが表示されていないことを確認する
    end
  end
end
