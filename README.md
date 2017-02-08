# Railsの開発環境(v5.0.1)

## 準備

Dockerをインストールします。
[https://www.docker.com/products/overview](https://www.docker.com/products/overview)

インストールが完了したらターミナルを開いて作業ディレクトリへ移動

```
$ git clone https://github.com/Islands5/docker-rails5
$ mv docker-rails5 your_project_name
$ cd your_project_name
$ grep -r project .
プロジェクト名に依存するファイルが出てくるので置換処理(ここのうまいワンライナーが見つからない。。。)

$ ruby -e "require 'securerandom'; puts SecureRandom.hex(64)"
#=> 長い文字列

secrets.ymlを編集します
$ vim config/secrets.yml
development:
  secret_key_base: 長い文字列

```

クローンされるディレクトリはRails構成 + dockerコンテナになってます。

コンテナを起動する際は

```
$ docker-compose up
Redis, MySQL, Rails, Nginxが立ち上がります。
ログが出力される状態になります。
一通りアクティベートの出力が終わったら次のコマンドを実行してください(うっとおしい時は、-dオプションをつけてください)

注)このコマンドは初回のみです
$ docker-compose run app rails db:create
```

を実行してください。

ブラウザでlocalhostへアクセスしたらRailsのオープニングページを確認できます。

## 開発

通常のrails開発と基本的には変わらないのですが、要所要所でdockerが絡んできます。
例えばrails c等のコマンドやrails db:create, rails db:migrateです。
これらはコンテナ内に存在するrailsコマンドに実行してもらう必要があるため

```
$ docker-compose run <コンテナ名> <コマンド>
```

のように実行します

Dockerfileを変更した場合は、コンテナを立ち上げ直す必要があるため

```
$ docker-compose build --no-cache
```

を実行してください

コンテナの中に入りたい時は

```
$ docker exec -it <コンテナIDorコンテナ名> /bin/bash
```

で実現できます。
例えばmysqlに直接コマンド打ち込みたい！
場合はmysqlのコンテナに入って
mysql -u root -p password
すればシェルに入ることができます。

## Dockerコマンドまとめ

工事中!

### DockerSyncをつかった同期設定(Docker for Macのみ)

必要なツールを入れて
```
gem install docker-sync
brew install fswatch
brew install unison
```

起動
```
$ docker-sync-stack start
```

上記のコマンドは以下の2つと同じ意味です
```
$ docker-sync start
$ docker-compose up
```

## 参考
Dockerで作る最強のWeb開発環境2017
http://qiita.com/osyoyu/items/a039b7e05abc6e97fb25

docker-composeで作成したネットワークの名前解決について
https://docs.docker.com/engine/userguide/networking/configure-dns/

dockerコマンドチートシート
http://qiita.com/voluntas/items/68c1fd04dd3d507d4083

docker execとdocker attachの違い
http://qiita.com/RyoMa_0923/items/9b5d2c4a97205692a560

docker-syncでコンテナホスト間を爆速で同期
http://qiita.com/pocari/items/0340049742927f3a94b7
