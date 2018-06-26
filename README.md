# kuma sns
（くまのいるsns）  

https://fathomless-spire-59127.herokuapp.com/

![アプリ画像](https://user-images.githubusercontent.com/3204814/41641922-c8eae28c-74a1-11e8-8520-1b23a67b4e71.png)

## 概要
画像を投稿してコメントをする形式のSNSアプリです。一般的なSNSと違う特色として、プログラムで作られたbotのような「くま」達が自動的に投稿したり、コメントしたり、チャットの相手をしたりします。

## 環境
* Ruby 2.4.1  
* Rails 5.1.4  
* DB PostgreSQL 10.3
* Bootstrap 4.0.0
* Heroku

## 機能
* sns認証、メール認証
* 記事の投稿、コメント
* ユーザのフォロー
* チャット機能（Action Cable使用）
* 通知機能

## プログラムで作られた「くま」ユーザの挙動
- くまは毎日0時に、ランダムな画像と文章で作られた投稿をします。  
- 自分がくまの投稿にコメントすると、くまもコメントをします。  
- 自分がくまをフォローすると、しばらくするとくまもフォローを返してきます。  
- 自分が投稿すると、相互フォロー関係にあるくまがコメントをします。  
- 相互フォロー関係にあるくまとチャットができます。自分がチャットに書き込むと、数秒後に相手のくまもチャットに書き込みます。  

## ER図
![ER図](https://user-images.githubusercontent.com/3204814/41644505-3177ccaa-74a9-11e8-88e3-4f813d6b1206.png)

## 実行方法
1. リポジトリをローカルにクローン  
```
git clone git@github.com:katanoZ/kuma_sns.git
```

2. 必要なGemをインストール  
```
bundle install
```

3. データベースを設定  
```
rails db:create  
rails db:migrate
```

4. アプリの起動  
```
rails server
```
