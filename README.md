# NePP_Library_Manager_backend

フロント側 ↓

https://github.com/nepp-tumsat/NePP_LibraryManager_Front

### なぜ作ったのか

NePP で管理している図書が、人の手では管理することが難しくなったので、システムを構築し、アプリで管理できるようにしたいため作成しました。

## 使用技術

フレームワーク：Ruby on rails

DB:postgresql

## 環境構築

git でこのリポジトリをクローン後、Docker を立ち上げ、VSCode で「コンテナーで再度開く」を押すと開発環境に入ります

ここで、環境変数は公開しないようにしているので、以前開発していた方から教えてもらってください(.envファイル)

開発環境に入ったら、

bin/setup (初回実行時のみ必須)

rails s -b 0.0.0.0 -p 3000 (バインドを指定せずに実行するとリクエストがDevContainerに届きません)

を順番に実行してください

変更を push する場合にはコンテナを抜けてローカルで push するようにしてください

また、開発に rubocop という静的コード解析ツールを使用しています。

コードに対して自動的に可読性、保守性を高めてくれるものなので、開発中に都度 bundle exec rubocop -A を使用してみてください

- Rails: `http://localhost:3000`
- MailHog: `http://localhost:8025`

## 工夫した点・苦労した点

Dockerfile, docker-compose.yml を用いた環境構築でつまづき、結局 template の内容を引っ張ってきて、devcontainer で動かすようにしました

#### API サーバー DB サーバーの準備

無料で利用でき、かつデプロイ状態がずっと続くサービスが見当たらず、苦戦しました。

また、サーバーや DB の制限の中、無料で利用するために Storage サービスを使用し、バックエンドではrender, DBサーバはsupabase、フロントエンドでそれぞれ別のホスティングサービスを使用しています
