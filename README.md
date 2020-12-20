# README

# アプリケーション名

### CAR-REVIEW

# アプリケーション概要

このアプリケーションでは、ユーザー登録をした人が車の評価やレビューを書き、  
それに対して別のユーザーがコメントやいいねをすることができるアプリケーションです。

# URL
### Heroku
https://car-review-31718.herokuapp.com/  
### EC2
http://18.180.112.122/  


# テスト用アカウント
メールアドレス：test@test.com  
パスワード：s174571  
(EC2の場合は's1745711453')

# 利用方法
トップページにアクセス後、ログインからテスト用アカウントにてログイン
右上に「テスト」のユーザー名が現れたらログイン成功です  
　　↓  
1.新規投稿より記事を投稿  
　　or  
2.レビュー一覧の詳細ボタンを押し詳細画面へ遷移  
  ・詳細画面のいいね！のハートマークを押すといいねができます。  
  ・コメント入力欄からコメントをすることができます  
  （投稿したレビューであれば編集、削除ができます）  
　　↓  
画面右上の「ログアウト」を押すとログアウトします  
  
トップページのフォームよりレビューの検索もできるようになりました  
  
# 目指した課題解決

車両購入の際に、直接ディーラーに行って話を聞くといくのは少しハードルが高いと思っていらっしゃる方が多いと思います。  
そんな方のために実際の利用者の生の評価が聞けるサイトがあればと思い、このアプリを作成しました。

# 実装した機能についての説明

## ユーザー管理機能
**新規登録の際はウィザード形式を採用し、入力のしやすさを向上しています。**
![a24fcf2192a879c87ea19c34bb1d66c5](https://user-images.githubusercontent.com/73088412/101593684-b0ddc880-3a33-11eb-90a7-64fcaa57d400.gif)  

**また、ログインは登録したメールアドレスとパスワードでもできますが**  
**SNS認証を採用しているのでGoogleアカウントでのログインも可能です。**  
**一度ユーザーと紐付けてしまえば、次回移行はSNS認証をするだけでログインが可能です。**
![0029515fbf3d930a6842f723061e4e00](https://user-images.githubusercontent.com/73088412/101597172-b0e0c700-3a39-11eb-8387-dd0dad89532e.gif)  

## レビュー投稿、一覧表示機能
**レビューは車両情報や各項目の評価、良い点、悪い点などを記入し投稿。**  
**投稿をするとトップページに一覧が表示されるようになります。**
![512b3d3325550a8f2ee03da99f76d228](https://user-images.githubusercontent.com/73088412/101598926-3d8c8480-3a3c-11eb-8de0-533e5d7c69e9.gif)  

## レビュー詳細表示機能
**トップページの各レビューの詳細ボタンを押すと詳細を表示することができます。**  
**この画面で投稿主は下記のことが出来るようになります。**  
**・レビューの編集**  
**・レビューの削除**  
**（投稿主以外のユーザーには編集、削除ボタンは見えません）**  
![86df5707e02fab14ba1a9a71dab29d52](https://user-images.githubusercontent.com/73088412/101600674-010e5800-3a3f-11eb-8fd6-3a674d4a532c.gif)  



## いいね機能
**レビュー詳細画面のハートマークを押すといいねができます。**  
**１回押すとマークに色がつきカウントが１上がり、もう１回押すと色がなくなりいいねが取り消せます。**

![004739c8073b5c528a0bea4d36b85653](https://user-images.githubusercontent.com/73088412/101599868-d5d73900-3a3d-11eb-8a1f-e7a96b6b440d.gif)  

## コメント投稿機能
**レビュー詳細画面にコメント入力欄からコメントの投稿をすることができます。**  
**投稿をしたらコメント欄に反映されます。**  
**また、コメント投稿主は削除ボタンからコメント削除ができます。**  
**（投稿主以外には表示されません）**
![482b184aadcd344f41c1a6fb22ef694b](https://user-images.githubusercontent.com/73088412/101600439-a37a0b80-3a3e-11eb-83bb-cad647975f84.gif)  

## レビュー検索機能
**トップページのフォームより検索したい車種を選択できます**  
**選択後検索ボタンを押すと検索結果一覧画面に遷移します**
![6c3c3d690afa518ea75af09f95df763c](https://user-images.githubusercontent.com/73088412/101858318-b4488f80-3bac-11eb-8ec6-7af19b44b5a8.gif)  



# 実装予定の機能
  
## ユーザー情報詳細表示機能
ユーザーの詳細情報を編集、表示できるようなページを作成予定  
自己紹介文など  
## GoogleMapを使った店舗検索機能
GoogleMapのAPIを導入し、ユーザー登録の際に入力した住所を参考に、近隣のディーラー検索をする機能  
## コメント投稿機能の非同期化
コメントを投稿したら非同期通信によりページ更新なしでコメントが反映される  
  
# テーブル設計

## ER図
![ER](https://user-images.githubusercontent.com/73088412/101856971-cb39b280-3ba9-11eb-8c88-581b70c8b1d9.png)


## users テーブル
| Column             | Type    | Options      |
| ------------------ | ------- | ------------ |
| nickname           | string  | unique: true |
| email              | string  | unique: true |
| encrypted_password | string  | null: false  |
| phone_number       | string  | null: false  |
| birthday           | date    | null: false  |

### Association

- has_many :reviews
- has_many :comments
- has_one :address
- has_many :sns_credentials


## addresses テーブル
| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| postal_code        | string     | null: false                    |
| prefecture_id      | integer    | null: false                    |
| municipality       | string     | null: false                    |
| street_number      | string     | null: false                    |
| building_name      | string     |                                |
| user               | references | null: false, foreign_key: true |

### Associations

- belongs_to :user


## reviews テーブル
| Column                 | Type       | Options                        |
| ---------------------- | ---------- | ------------------------------ |
| automaker_id           | integer    | null: false                    |
| model_of_car           | string     | null: false                    |
| grade                  | string     | null: false                    |
| era_name_id            | integer    | null: false                    |
| model_year             | integer    |                                |
| design_id              | integer    | null: false                    |
| driving_performance_id | integer    | null: false                    |
| ride_comfort_id        | integer    | null: false                    |
| lording_id             | integer    | null: false                    |
| fuel_economy_id        | integer    | null: false                    |
| price_id               | integer    | null: false                    |
| good_point             | text       | null: false                    |
| bad_point              | text       | null: false                    |
| likes_count            | integer    |                                |
| user                   | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many :comments

## comments テーブル
| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| text   | text       | null: false                    |
| user   | references | null: false, foreign_key: true |
| review | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :review

## likes テーブル
| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| review | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :review

## sns_credentials テーブル
| Column     | Type       | Options                        |
| ---------- | ---------- | ------------------------------ |
| provider   | string     |                                |
| uid        | string     |                                |
| user       | references | null: false, foreign_key: true |

### Association
- belongs_to :user



