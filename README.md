# Inception

42TokyoのInceptionプロジェクト - DockerとDocker Composeを使用してWordPressサイトをデプロイします。

## 概要

このプロジェクトは、3つのコンテナを使用してWordPressサイトを構築します：
- **NGINX** - リバースプロキシ・Webサーバー（HTTPS対応）
- **WordPress** - PHPアプリケーション（PHP-FPM）
- **MariaDB** - データベースサーバー

## 必要なファイル

実行前に`.env`ファイルを作成してください

## 使用方法

### 基本コマンド

```bash
# 全てのサービスを起動
make

# または
make up

# サービスを停止
make down

# 完全にクリーンアップ
make fclean

# 再構築
make re
```

### 詳細コマンド

```bash
# 必要なディレクトリを作成
make prepare

# コンテナをビルド
make build

# サービスを停止（データ保持）
make stop

# コンテナとボリュームを削除
make clean
```

## アクセス方法

サービス起動後、以下のURLでアクセス可能です：

- **WordPress サイト**: https://localhost
- **WordPress 管理画面**: https://localhost/wp-admin

## ディレクトリ構成

```
inception/
├── Makefile
├── README.md
└── srcs/
    ├── docker-compose.yml
    ├── .env
    └── requirements/
        ├── mariadb/
        │   ├── Dockerfile
        │   ├── conf/my.cnf
        │   └── tools/init.sh
        ├── nginx/
        │   ├── Dockerfile
        │   ├── conf/nginx.conf
        │   └── tools/init.sh
        └── wordpress/
            ├── Dockerfile
            ├── conf/www.conf
            └── tools/init.sh
```

## データの永続化

以下のディレクトリにデータが保存されます：
- `~/data/db_data/` - MariaDBデータ
- `~/data/wp_data/` - WordPressファイル
- `~/data/ssl_certs/` - SSL証明書

## 注意事項

- 初回起動時は、コンテナのビルドに時間がかかる場合があります
- SSL証明書は自己署名証明書のため、ブラウザで警告が表示される場合があります
- データを完全に削除する場合は`make fclean`を実行してください

## トラブルシューティング

### ポートが使用中の場合
```bash
# ポート443を使用しているプロセスを確認
sudo lsof -i :443

# 必要に応じてプロセスを停止
sudo kill -9 <PID>
```

### 権限エラーの場合
```bash
# Dockerグループにユーザーを追加
sudo usermod -aG docker $USER

# 再ログインが必要
```

## 42 Tokyo課題要件

 - すべてのコンテナは独自のDockerfileから構築
 - debian:bullseyeまたはalpine:3.16ベースイメージ使用
 - 各サービスは専用コンテナで実行
 - HTTPSのみでアクセス可能
 - WordPressデータベースに2つのユーザー（管理者・一般ユーザー）
 - ボリュームによるデータ永続化
 - Docker Networkによるコンテナ間通信
 - 環境変数による設定管理
