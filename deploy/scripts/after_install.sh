#!/bin/bash
set -e

APP_DIR=/usr/share/nginx/html
WEB_USER=nginx
WEB_GROUP=nginx

cd "$APP_DIR"

# 所有者変更（ここが今足りてないところ）
chown -R "$WEB_USER":"$WEB_GROUP" \
  storage \
  bootstrap/cache

# パーミッション調整
find storage -type d -exec chmod 775 {} \;
find storage -type f -exec chmod 664 {} \;

find bootstrap/cache -type d -exec chmod 775 {} \;
find bootstrap/cache -type f -exec chmod 664 {} \;

# composer インストール
/usr/bin/php /usr/bin/composer install --no-dev --optimize-autoloader

# .env はEC2側に置いておく前提（Git管理しない）
php artisan key:generate --force || true
php artisan config:cache
php artisan route:cache
