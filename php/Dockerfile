# Use PHP 8.2 with Apache
FROM php:8.2-apache

# Set working directory
WORKDIR /var/www/html

# Install system dependencies
RUN apt-get update && apt-get install -y \
  libpq-dev \
  git \
  unzip \
  && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-install pdo pdo_pgsql

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copy composer files
COPY composer*.json ./

# Install dependencies
RUN composer install --no-dev --optimize-autoloader

# Copy application files
COPY . .

# Set permissions
RUN chown -R www-data:www-data /var/www/html

# Enable Apache modules
RUN a2enmod rewrite

# Expose port
EXPOSE 8000

# Start Apache
CMD ["apache2-foreground"]
