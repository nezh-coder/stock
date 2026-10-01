FROM php:8.3-fpm

# =========================
# PHP / System dependencies
# =========================
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    curl \
    ca-certificates \
    libzip-dev \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    libonig-dev \
    libxml2-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install \
        pdo_mysql \
        mbstring \
        exif \
        pcntl \
        bcmath \
        gd \
        zip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# =========================
# Node.js 22 + npm
# =========================
COPY --from=node:22 /usr/local/ /usr/local/

ENV PATH="/usr/local/bin:${PATH}"

RUN node --version && npm --version



# =========================
# Composer
# =========================
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

# =========================
# Laravel application
# =========================
COPY . .

# =========================
# Composer dependencies
# =========================
RUN composer install \
    --no-interaction \
    --prefer-dist \
    --optimize-autoloader

# =========================
# Laravel permissions
# =========================
RUN chown -R www-data:www-data \
    storage \
    bootstrap/cache

EXPOSE 9000

CMD ["php-fpm"]