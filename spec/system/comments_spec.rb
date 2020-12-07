require 'rails_helper'


RSpec.describe 'コメント投稿', type: :system do
  before do
    @review = FactoryBot.create(:review)
    @comment = Faker::Lorem.sentence
  end

  it 'ログインしているユーザーはレビュー詳細ページでコメントができる' do
    # レビューを投稿したユーザーでログインする
    visit new_user_session_path
    fill_in 'user[email]', with: @review.user.email
    fill_in 'user[password]', with: @review.user.password
    find('input[name="commit"]').click
    expect(current_path).to eq root_path
    # レビューの詳細ページへ移動する
    visit review_path(@review)
    # フォームにコメントを入力する
    fill_in 'コメント入力欄', with: @comment
    # コメントを送信すると、Commentモデルのカウントが1上がることを確認する
    expect{
      find('input[name="commit"]').click
    }.to change { Comment.count }.by(1)
    # 詳細ページにリダイレクトされることを確認する
    expect(current_path).to eq review_path(@review)
    # 詳細ページ上に先ほどのコメント内容が含まれていることを確認する
    expect(page).to have_content @comment
  end
end
