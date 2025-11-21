#!/bin/bash
set -e

# nginx + php-fpm の例
systemctl restart php-fpm || systemctl restart php8.4-fpm
systemctl restart nginx || systemctl restart httpd
