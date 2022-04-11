# Bitbucket Pipelines PHP 7.4 image

## Based on Ubuntu 18.04

### Packages installed

- `php7.4-zip`, `php7.4-xml`, `php7.4-mbstring`, `php7.4-curl`, `php7.4-json`, `php7.4-imap`, `php7.4-mysql`, `php7.4-sqlite`,`php7.4-tokenizer`, `php7.4-xdebug`, `php7.4-intl`, `php7.4-soap`, `php7.4-pdo`, `php7.4-cli`, `php7.4-gd`, `php7.4-gmp` and `php7.4-apcu`
- wget, curl, unzip
- Composer
- Mysql 5.7
- Sqlite3
- Node + Yarn
- Mongodb

### Sample `bitbucket-pipelines.yml`

```YAML
image: leolojacorr/lamp-mongo-laravel-php7.4
pipelines:
  default:
    - step:
        script:
          - service mysql start
          - mysql -h localhost -u root -proot -e "CREATE DATABASE test;"
          - composer install --no-interaction --no-progress --prefer-dist
          - ./vendor/phpunit/phpunit/phpunit -v --coverage-text --colors=never --stderr
        services:
          - mongo
definitions:
  services:
    mongo:
      image: mongo          
```
