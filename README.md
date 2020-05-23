# Solopacker
<img width="1423" alt="Screen Shot 2020-05-23 at 18 18 51" src="https://user-images.githubusercontent.com/54460011/82726875-f5b54280-9d21-11ea-85bc-a1515ee5569c.png">


## URL
https://solopacker.work/

## アプリ概要
一人旅行中の隙間時間や寂しくなった時に仲間を見つけられるサービスです。
空いた時間に同じように暇してる旅行者を募集して、一緒にご飯を食べたり遊びに行ったりできます。

## 作成動機
自分自身、海外旅行が好きで良く旅行に行きます。その際、暇な時間を一緒に潰してくれる人が見つけられればなと思いこのアプリを作成しました。

## 特に力を入れた点
- GoogleMapや通貨レートなど3つのAPIを使った実装
- コルクボードを意識したわかりやすいUI
- ペルソナは海外旅行者のため全て英語表記
- ユーザーの登録情報を元にしたデフォルト画面（Home画面はユーザーの現在地の国がデフォルトで表示される）
- JavaScriptを使った非同期処理（参加やコメントだけでなく募集一覧、検索、ページネーションにも対応）
- コルクボード上のピンを利用した簡単検索
- Google Autocompleteを利用した自動補完
- Request, Model, System Specを使ったTDD開発

## ER図
<img width="801" alt="Screen Shot 2020-04-29 at 11.20.20.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/544362/7975bcae-0674-af93-f661-efd5a218b261.png">


## 機能一覧
#### 認証周り
- ログイン、サインアップ機能(devise)
  - email、パスワード、ユーザー名必須(ログイン時はemailとパスワードのみ)
  - ゲストログイン機能(ゲストユーザーはプロフィール変更不可)

#### 募集機能
- CRUD機能（Google Place Autocomplete API使用）
- 検索機能(Ajax)
- 参加機能(Ajax)
- コメント機能(Ajax)

#### マップ機能
- 募集のマップ機能（Google Map Geocoding Service API使用）

#### 通貨レート機能
- 自国通貨 ⇄ 他国通貨レート機能（国際通貨レートAPI使用, Ajax）


## 使用技術
- ruby '2.6.5'
- rails '6.0.2'
- RSpec
- slim
- JavaScript







