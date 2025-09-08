# NePP_Library_Manager_backend
フロント側↓

https://github.com/nepp-tumsat/NePP_LibraryManager_Front

### なぜ作ったのか

NePP で管理している図書が、人の手では管理することが難しくなったので、システムを構築し、アプリで管理できるようにしたいため作成しました。

## 使用技術

フレームワーク：Ruby on rails

DB:postgresql(本番環境)

## 環境構築

git でこのリポジトリをクローン後、Docker を立ち上げ、VSCode で「コンテナーで再度開く」を押すと開発環境に入ります

開発環境に入ったら、

bin/setup

rails s

を順番に実行してください

変更を push する場合にはコンテナを抜けてローカルで push するようにしてください

また、開発に rubocop という静的コード解析ツールを使用しています。

コードに対して自動的に可読性、保守性を高めてくれるものなので、開発中に都度 bundle exec rubocop -A を使用してみてください

## 工夫した点・苦労した点

Dockerfile, docker-compose.yml を用いた環境構築でつまづき、結局 template の内容を引っ張ってきて、devcontainerで動かすようにしました

#### API サーバー DB サーバーの準備

無料で利用でき、かつデプロイ状態がずっと続くサービスが見当たらず、苦戦しました。

また、サーバーやDBの制限の中、無料で利用するためにStorageサービスを使用し、バックエンドではsupabase、フロントエンドでそれぞれ別のホスティングサービスを使用しています
