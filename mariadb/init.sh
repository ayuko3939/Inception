#!/bin/bash

# 環境変数が設定されているか確認
echo "hello test!"
echo "MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}"
echo "MYSQL_DATABASE=${MYSQL_DATABASE}"
echo "MYSQL_USER=${MYSQL_USER}"
echo "MYSQL_PASSWORD=${MYSQL_PASSWORD}"

cat << EOF > /etc/init.sql
-- ① rootユーザーのパスワードを設定（必要に応じて変更）
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
-- ② WordPress用のデータベースを作成
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE} CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
-- ③ WordPress用のユーザーを作成（なければ作る）
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
-- ④ WordPress用のユーザーにデータベースへの全権限を付与
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
-- 設定を反映
FLUSH PRIVILEGES;
EOF

# mysqld --init-file=/etc/init.sql
mysql -u root -p "${MYSQL_ROOT_PASSWORD}" < /etc/init.sql
sleep 5
exec mysqld