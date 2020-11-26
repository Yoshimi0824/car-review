# README

# アプリケーション名

CAR-REVIEW

# アプリケーション概要

このアプリケーションでは、ユーザー登録をした人が
車の評価やレビューを書き、それに対して別のユーザーが
コメントすることができるアプリケーションです。

# URL


# テスト用アカウント

# 利用方法

# 目指した課題解決

車両を購入する上でディーラーに行くことはハードルが高いという認識を持っている方へ、
気になっている車種の利用者の声を聞くことができる場を作れればという思いから
このアプリケーションを作成しました。

# 実装した機能についての説明

# 実装予定の機能

# テーブル設計

## users テーブル
| Column             | Type    | Options      |
| ------------------ | ------- | ------------ |
| nickname           | string  | unique: true |
| email              | string  | unique: true |
| phone_number       | string  | null: false  |
| birthday           | date    | null: false  |
| postal_code        | string  | null: false  |
| encrypted_password | string  | null: false  |
| prefecture_id      | integer | null: false  |
| municipality       | string  | null: false  |
| street_number      | string  | null: false  |
| building_name      | string  |              |

### Association

- has_many :reviews
- has_many :comments



## reviews テーブル
| Column                 | Type       | Options                        |
| ---------------------- | ---------- | ------------------------------ |
| automaker_id           | integer    | null: false                    |
| vehicle_type           | string     | null: false                    |
| grade                  | string     | null: false                    |
| model_year_wareki_id   | integer    | null: false                    |
| model_year             | string     | null: false                    |
| design_id              | integer    | null: false                    |
| driving_performance_id | integer    | null: false                    |
| ride_comfort_id        | integer    | null: false                    |
| lording_id             | integer    | null: false                    |
| fuel_economy_id        | integer    | null: false                    |
| good_point             | text       | null: false                    |
| bad_point              | text       | null: false                    |
| user                   | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many :comments

## comments テーブル

- belongs_to :user
- belongs_to :review


