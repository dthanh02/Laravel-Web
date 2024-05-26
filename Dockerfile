# Sử dụng PHP FPM image làm base
FROM php:8.2-fpm
# Cài đặt các dependencies cần thiết
RUN apt-get update && apt-get install -y \
    git \
    zip \
    unzip \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev

# Enable PHP extensions
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd zip

# Cài đặt Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set up working directory
WORKDIR /var/www/html

# Copy mã nguồn ứng dụng vào image
COPY . .

# Cài đặt các dependencies của Laravel
RUN composer install

# Command để khởi chạy ứng dụng khi container được tạo
# CMD php artisan serve --host=0.0.0.0 --port=8000
CMD php artisan serve

