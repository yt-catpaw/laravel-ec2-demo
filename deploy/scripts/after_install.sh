#!/bin/bash
set -e

APP_DIR=/usr/share/nginx/html

cd $APP_DIR

# パーミッション調整（必要に応じて）
# chown -R ec2-user:ec2-user $APP_DIR
chmod -R ug+rwx storage bootstrap/cache

# composer インストール（composer が /usr/bin/composer じゃなければパスを直す）
/usr/bin/php /usr/bin/composer install --no-dev --optimize-autoloader

# .env はEC2側に置いておく前提（Git管理しない）
php artisan key:generate --force || true
# php artisan migrate --force || true
php artisan config:cache
php artisan route:cache
