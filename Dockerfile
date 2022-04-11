FROM ubuntu:18.04

# Set environment variables
ENV HOME /root

# MySQL root password
ARG MYSQL_ROOT_PASS=root

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    software-properties-common \
    git \
    ca-certificates \
    unzip \
    mcrypt \
    wget \
    openssl \
    ssh \
    locales \
    less \
    sudo \
    mysql-server \
    curl \
    libmcrypt-dev \
    default-mysql-client \
    libjpeg-dev \
    libpng-dev \
    libfreetype6-dev \
    gnupg \
    sqlite3 \
    nodejs \
    --no-install-recommends && \
    add-apt-repository ppa:ondrej/php
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN pecl install mongodb && docker-php-ext-enable mongodb

# Install packages
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    yarn \
    php-pear php7.4-sqlite php7.4-mysql php7.4-zip php7.4-xml php7.4-mbstring php7.4-curl php7.4-json php7.4-pdo php7.4-tokenizer php7.4-cli php7.4-imap php7.4-intl php7.4-gd php7.4-xdebug php7.4-soap php7.4-gmp php7.4-apcu \
    apache2 libapache2-mod-php7.4 composer \
    --no-install-recommends && \
    apt-get clean -y && \
    apt-get autoremove -y && \
    apt-get autoclean -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    rm /var/lib/mysql/ib_logfile*



# Ensure UTF-8
ENV LANG       en_US.UTF-8
ENV LC_ALL     en_US.UTF-8
RUN locale-gen en_US.UTF-8

# Timezone & memory limit
RUN echo "date.timezone=Europe/Chisinau" > /etc/php/7.4/cli/conf.d/date_timezone.ini && echo "memory_limit=1G" >> /etc/php/7.4/apache2/php.ini

# Goto temporary directory.
WORKDIR /tmp
