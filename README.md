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
1. ```composer global require xtrime-ru/php-extensions-toggle```

## Usage
```
php-extensions xdebug on
php-extensions xdebug off
php-extensions apcu on
```
