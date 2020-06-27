# Solopacker

## 使用画面

| トップページ | レート |
| :-- | :-- |
| ![Screen Shot 2020-05-23 at 18 13 52](https://user-images.githubusercontent.com/54460011/85916358-22152f00-b88b-11ea-9f70-75c8c432c1d6.png) | ![Screen Shot 2020-06-27 at 14 46 43](https://user-images.githubusercontent.com/54460011/85916377-47a23880-b88b-11ea-882d-3519e01b75f4.png) |

| 募集一覧 | 募集一覧（GoogleMap） |
| :-- | :-- |
| ![Screen Shot 2020-06-27 at 14 41 34](https://user-images.githubusercontent.com/54460011/85916370-3eb16700-b88b-11ea-92db-e499b2fbe967.png)| ![Screen Shot 2020-06-27 at 14 44 36](https://user-images.githubusercontent.com/54460011/85916373-42dd8480-b88b-11ea-82d9-5f9a63478f0b.png)

## URL
https://solopacker.work/

## アプリ概要
一人旅行中の隙間時間や寂しくなった時に仲間を見つけられるサービスです。
空いた時間に同じように暇してる旅行者を募集して、一緒にご飯を食べたり遊びに行ったりできます。

## 作成動機
自分自身、海外旅行が好きで良く旅行に行きます。その際、暇な時間を一緒に潰してくれる人が見つけられればなと思いこのアプリを作成しました。

## ペルソナ
- 一人旅行好き
- バックパッカー
- 20 ~ 40代男女
- 友だち少なめ（もしくは仕事の都合で予定が合わない）
- 観光地など自分で調べるのがあまり好きじゃない


## 特に力を入れた点
- Request, Model, System Specを使ったTDD開発
- GoogleMapや通貨レートなど3つのAPIを使った実装
- コルクボードやピンを使うなどわかりやすいUI/UX
- ユーザーの登録情報を元にしたデフォルト画面（Home画面はユーザーの現在地の国がデフォルトで表示される）
- Google Autocompleteを利用した自動補完など使いやすい操作性

## ER図
<img width="801" alt="Screen Shot 2020-04-29 at 11.20.20.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/544362/7975bcae-0674-af93-f661-efd5a218b261.png">

## 機能一覧
### 認証周り
- ログイン、サインアップ機能(devise)
  - email、パスワード、ユーザー名必須(ログイン時はemailとパスワードのみ)
  - ゲストログイン機能(ゲストユーザーはプロフィール変更不可)

### 募集機能
- CRUD機能（Google Place Autocomplete API使用）
- 検索機能(Ajax)
- 参加機能(Ajax)
- コメント機能(Ajax)

### マップ機能
- 募集のマップ機能（Google Map Geocoding Service API使用）

### 通貨レート機能
- 自国通貨 ⇄ 他国通貨レート機能（国際通貨レートAPI使用, Ajax）

## 使用技術
- Ruby '2.6.5'
- Rails '6.0.2'
- RSpec
- Slim
- JavaScript
- Bootstrap4
- MySQL
- AWS(VPC, EC2, S3, ALB, Route53, ACM)

## 良かった点
- MENTAでメンターの方を探しPRベースで開発できた。
- ブランチとissueとPRを紐付け擬似チーム開発の形で開発できた。
- ペルソナは海外旅行者のため全て英語表記。
- 競合するようなアプリを実際に使ってみて研究し、良い点を取り入れた。
- JavaScriptを使った非同期処理（参加やコメントだけでなく募集一覧、検索、ページネーションにも対応）
- デプロイ後にメンターさんやエンジニア仲間からのフィードバックを反映（https://github.com/yohei04/solopacker/issues/59）

## 苦労した点
- Rails6を使用したため参考記事が少なかった。
- Google Mapとturbolinksの相性が悪く、初めは原因が分からなかった。
- 参加ボタンをAjaxにして条件分岐する際のflashの出し方。
- AWSを使ったデプロイ。

## 反省点
- 開発の期間を決めなかったため実装に2か月半もかかってしまった。
- ピンの色や位置などあまり意味のないこだわりに時間をかけすぎてしまった。
- Google Maps APIの挙動がわからずコピペのところがある。
- 今のままだとユーザーの信頼度が低いため安心して使いにくい。

## 今後実装していきたい機能
- 募集のカテゴリー分け機能(観光、食、ショッピングなど)
- 募集の現地人と観光客を分ける機能
- ユーザーのおすすめスポット紹介機能
- 他ユーザーから自分を紹介してもう機能
- 旅程メモ・公開機能
- facebookログイン機能
