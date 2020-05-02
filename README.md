# PHP Extension Toggle
Toggle php extensions from command line

## How it works?
 - Search for all .ini files in php directory
 - Find line where specified extension loaded 
 - Add or remove `;` at the beginning of the line
 - Try restart `fpm`, `apache` and `brew php`

## Requirements 
- Linux or MacOs
- Brew to restart php on mac os
- `service` command to restart php-fpm or apache on linux

## Install
```
composer create-project xtrime-ru/php-extensions-toggle && rm -rf php-extensions-toggle/
```

## Remove
```rm /usr/local/bin/php-extension```

## Usage
```
php-extensions xdebug on
php-extensions xdebug off
php-extensions apcu on
```
