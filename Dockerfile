# PHP Native Dashboard - Docker Configuration
# Based on php-todo reference implementation

# Use official PHP-FPM image (stable version 8.1)
FROM php:8.1-fpm

# Set working directory inside container
WORKDIR /var/www/html

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    default-mysql-client \
    && rm -rf /var/lib/apt/lists/*

# Install PHP extensions needed for the dashboard
# pdo_mysql: for MySQL database connection
# mbstring: for multibyte string handling
# gd: for image manipulation (if needed for avatars/images)
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# DO NOT copy application files here - we use volume mounting
# This allows live reload during development
# Students can edit PHP/CSS files and see changes immediately

# Set permissions for application directory (will be overridden by volume)
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Expose port 9000 for PHP-FPM
EXPOSE 9000

# Health check to ensure PHP-FPM is running properly
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD php-fpm -t || exit 1

# Run PHP-FPM in foreground
CMD ["php-fpm"]