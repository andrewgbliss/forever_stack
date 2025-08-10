# Use Perl 5.34 for smaller image size
FROM perl:5.34

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
  libpq-dev \
  gcc \
  make \
  && rm -rf /var/lib/apt/lists/*

# Install Perl modules
RUN cpanm --no-wget \
  Dancer2 \
  DBD::Pg \
  DBI \
  Plack \
  Starman

# Copy application files
COPY . .

# Install application dependencies
RUN cpanm --installdeps .

# Expose port
EXPOSE 5000

# Start the application
CMD ["perl", "app.pl"]
