#!/bin/bash

EXTENSION="$1"
[ "$2" == 'on' ] || [ "$2" == '1' ] || [ "$2" == 'enable' ] && ENABLE=true || ENABLE=false
PHP_DIR=$(php --ini | grep 'Configuration File (php.ini) Path:' | sed -E "s~^.*: (.*/php/[^/]*).*$~\1/~")
if [[ "$OSTYPE" == "darwin"* ]]; then
  #MAC_OS
  SED_ARGS="-i '' -E";
else
  #OTHER
  SED_ARGS="-i -E";
fi

if [ "$EXTENSION" == '' ]; then
  echo 'Error: no extension provided'
  exit 1;
fi

#toogle extension line in .ini file:
find "$PHP_DIR" -type f -name "*.ini" | while read -r FILE; do
  if [ "$ENABLE" == true ]; then
     COMMAND=("sed $SED_ARGS s/^;((zend_extension|extension).+$EXTENSION\.so\"?)$/\1/g $FILE")
  else
     COMMAND=("sed $SED_ARGS s/^((zend_extension|extension).+$EXTENSION\.so\"?)$/;\1/g $FILE")
  fi

$COMMAND

done

#restart fpm
echo 'Restart fpm ...'
PHP_VERSION=$(php -v | grep '^PHP ' | sed -E "s/^PHP ([0-9]\.[0-9]).*$/\1/")
/etc/init.d/php"$PHP_VERSION"-fpm restart 2> /dev/null
/etc/init.d/php-fpm restart 2> /dev/null

#restart apache
echo 'Restart apache ...'
service apache2 restart 2> /dev/null

#restart on MAC
echo 'Restart brew php ...'
brew services restart php@"$PHP_VERSION" 2> /dev/null

