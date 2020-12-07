require 'rails_helper'

RSpec.describe "レビュー投稿", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @review = FactoryBot.build(:review)
  end

  context 'レビュー投稿できるとき' do
    it 'ログインしたユーザーは新規投稿できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 新規投稿ページへのリンクがあることを確認する
      expect(page).to have_content('新規投稿')
      # 投稿ページに移動する
      visit new_review_path
      # フォームに情報を入力する
      select @review.automaker.name, from: 'review[automaker_id]'
      fill_in 'review[model_of_car]', with: @review.model_of_car
      fill_in 'review[grade]', with: @review.grade
      select @review.era_name.name, from: 'review[era_name_id]'
      fill_in 'review[model_year]', with: @review.model_year
      select '３点', from: 'review[design_id]'
      select '３点', from: 'review[driving_performance_id]'
      select '３点', from: 'review[ride_comfort_id]'
      select '３点', from: 'review[lording_id]'
      select '３点', from: 'review[fuel_economy_id]'
      select '３点', from: 'review[price_id]'
      fill_in 'review[good_point]', with: @review.good_point
      fill_in 'review[bad_point]', with: @review.bad_point
      # 送信するとReviewモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Review.count }.by(1)
      # トップページに遷移していることを確認する
      expect(current_path).to eq root_path
      # トップページには先ほど投稿した内容のレビューが存在することを確認する(メーカー、車種、投稿者)
      expect(page).to have_content(@review.automaker.name)
      expect(page).to have_content(@review.model_of_car)
      expect(page).to have_content(@user.nickname)
    end

    context 'レビュー投稿できないとき' do
      it 'ログインしていないと新規投稿ページに遷移できない' do
        # トップページに遷移する
        visit root_path
        # 新規投稿ページへのリンクがない
        expect(page).to have_no_content('新規投稿')
      end

      it 'ログインしていても情報を入力しなければ新規投稿できない' do
        # ログインする
        visit new_user_session_path
        fill_in 'user[email]', with: @user.email
        fill_in 'user[password]', with: @user.password
        find('input[name="commit"]').click
        expect(current_path).to eq root_path
        # 新規投稿ページへのリンクがあることを確認する
        expect(page).to have_content('新規投稿')
        # 投稿ページに移動する
        visit new_review_path
        # フォームに情報を入力する
        select '---', from: 'review[automaker_id]'
        fill_in 'review[model_of_car]', with: " "
        fill_in 'review[grade]', with: " "
        select '---', from: 'review[era_name_id]'
        fill_in 'review[model_year]', with: " "
        select '---', from: 'review[design_id]'
        select '---', from: 'review[driving_performance_id]'
        select '---', from: 'review[ride_comfort_id]'
        select '---', from: 'review[lording_id]'
        select '---', from: 'review[fuel_economy_id]'
        select '---', from: 'review[price_id]'
        fill_in 'review[good_point]', with: " "
        fill_in 'review[bad_point]', with: " "
        # 投稿ボタンを押してもReviewモデルのカウントが上がらないことを確認する
        expect{
          find('input[name="commit"]').click
        }.to change { Review.count }.by(0)
        # 新規投稿ページに戻されることを確認する
        expect(current_path).to eq reviews_path
      end
    end
  end 
end


RSpec.describe 'レビュー編集', type: :system do
  before do
    @review1 = FactoryBot.create(:review)
    @review2 = FactoryBot.create(:review)
  end

  context 'レビュー編集が出来るとき' do
    it 'ログインしたユーザーは自分が投稿したレビューを編集できる' do
      # レビュー1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'user[email]', with: @review1.user.email
      fill_in 'user[password]', with: @review1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # レビュー１の詳細ボタンを押す
      expect(
        all(".btn-group")[1]
      ).to have_link '詳細', href: review_path(@review1)
      # 詳細ページに遷移したら、編集ボタンがあることを確認する
      visit review_path(@review1)
      expect(page).to have_link '編集', href: edit_review_path(@review1)
      # 編集ページに遷移する
      visit edit_review_path(@review1)
      # すでに投稿済みの内容がフォームに入っていることを確認する
      expect(
        find('#review_automaker_id').value
      ).to eq "#{@review1.automaker_id}"
      expect(
        find('#review_model_of_car').value
      ).to eq "#{@review1.model_of_car}"
      expect(
        find('#review_grade').value
      ).to eq "#{@review1.grade}"
      expect(
        find('#review_era_name_id').value
      ).to eq "#{@review1.era_name_id}"
      expect(
        find('#review_model_year').value
      ).to eq "#{@review1.model_year}"
      expect(
        find('#review_design_id').value
      ).to eq "#{@review1.design_id}"
      expect(
        find('#review_driving_performance_id').value
      ).to eq "#{@review1.driving_performance_id}"
      expect(
        find('#review_ride_comfort_id').value
      ).to eq "#{@review1.ride_comfort_id}"
      expect(
        find('#review_lording_id').value
      ).to eq "#{@review1.lording_id}"
      expect(
        find('#review_fuel_economy_id').value
      ).to eq "#{@review1.fuel_economy_id}"
      expect(
        find('#review_price_id').value
      ).to eq "#{@review1.price_id}"
      expect(
        find('#review_good_point').value
      ).to eq "#{@review1.good_point}"
      expect(
        find('#review_bad_point').value
      ).to eq "#{@review1.bad_point}"
      # 投稿内容を編集する
      select 'ダイハツ', from: 'review[automaker_id]'
      select '４点', from: 'review[design_id]'
      fill_in 'review[good_point]', with: "#{@review1.good_point}+追加テキスト"
      # 編集してもReviewモデルのカウントは変わらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Review.count }.by(0)
      # 詳細ページに遷移することを確認する
      expect(current_path).to eq review_path(@review1)
      # 詳細ページに先程変更した良い点が反映されている
      expect(page).to have_content("#{@review1.good_point}+追加テキスト")
    end
  end

  context 'レビュー編集出来ないとき' do
    it 'ログインしたユーザーは自分以外が投稿したツイートの編集画面には遷移できない' do
      # レビュー1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'user[email]', with: @review1.user.email
      fill_in 'user[password]', with: @review1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # レビュー2の詳細ボタンを押す
      expect(
        all(".btn-group")[0]
      ).to have_link '詳細', href: review_path(@review2)
      # レビュー２の詳細ページに編集ボタンが無いことを確認する
      expect(page).to have_no_content('編集')
    end

    it 'ログインしていないとレビューの編集画面に遷移できない' do
      # トップページにいる
      visit root_path
      # レビュー１の詳細ボタンを押す
      expect(
        all(".btn-group")[1]
      ).to have_link '詳細', href: review_path(@review1)
      # レビュー１の詳細ページに編集ボタンが無いことを確認する
      expect(page).to have_no_content('編集')
    end
  end
end


RSpec.describe 'レビュー削除', type: :system do
  before do
    @review = FactoryBot.create(:review)
    @user2 = FactoryBot.create(:user)
  end

  context 'レビューが削除出来るとき' do
    it 'レビュー投稿者は自分のレビューを削除できる' do
      # レビューを投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'user[email]', with: @review.user.email
      fill_in 'user[password]', with: @review.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # レビューの詳細ページへ移動する
      visit review_path(@review)
      # 削除ボタンを押すと、Reviewモデルのレコードが１つ減る
      expect{
        find_link('削除', href: review_path(@review)).click
      }.to change { Review.count }.by(-1)
      # トップページに遷移していることを確認する
      expect(current_path).to eq root_path
      # トップページにレビューの内容がないことを確認する
      expect(page).to have_no_content("#{@review.automaker.name}")
      expect(page).to have_no_content("#{@review.model_of_car}")
      expect(page).to have_no_content("投稿者：#{@review.user.nickname}")
    end
  end

  context 'レビューが削除できないとき' do
    it 'レビュー投稿者以外のユーザーでログインするとレビュー削除ができない' do
      # レビューを投稿した以外のユーザーでログインする
      visit new_user_session_path
      fill_in 'user[email]', with: @user2.email
      fill_in 'user[password]', with: @user2.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # レビューの詳細ページへ移動する
      visit review_path(@review)
      # 詳細ページに削除ボタンが存在しない
      expect(page).to have_no_content('削除')
    end

    it 'ログインしないとレビュー削除ができない' do
      # レビューの詳細ページへ移動する
      visit review_path(@review)
      # 詳細ページに削除ボタンが存在しない
      expect(page).to have_no_content('削除')
    end
  end
end


RSpec.describe 'レビュー詳細', type: :system do
  before do
    @review = FactoryBot.create(:review)
    @user2 = FactoryBot.create(:user)
  end

  context 'ログインしていないとき' do
    it 'ログインしていないとコメント入力欄が表示されない' do
      # レビューの詳細ページへ移動する
      visit review_path(@review)
      # レビューの詳細ページにコメント入力欄が存在しない
      expect(page).to have_no_content('コメント入力欄')
    end
  end

  context 'ログインしているとき' do
    it 'ログインすると、コメント入力欄が表示される' do
      # レビューを投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'user[email]', with: @review.user.email
      fill_in 'user[password]', with: @review.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # レビューの詳細ページへ移動する
      visit review_path(@review)
      # レビュー詳細ページにコメント入力欄があることを確認する
      expect(page).to have_content('コメント入力欄')
    end
  end
end
