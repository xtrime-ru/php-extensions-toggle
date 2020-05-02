#!/bin/bash

EXTENSION="$1"
[ "$2" == 'on' ] || [ "$2" == '1' ] || [ "$2" == 'enable' ] && ENABLE=true || ENABLE=false
INI_DIR=$(php --ini | grep 'Configuration File (php.ini) Path:' | sed -E "s/.*: //")

if [ "$EXTENSION" == '' ]; then
  echo 'Error: no extension provided'
  exit 1;
fi

#toogle extension line in .ini file:
find "$INI_DIR" -type f -name "*.ini" | while read -r FILE; do
  if [ "$ENABLE" == true ]; then
    sed -i '' -E "s/^;((zend_extension|extension).+$EXTENSION\.so)$/\1/g" "$FILE"
  else
    sed -i '' -E "s/^((zend_extension|extension).+$EXTENSION\.so)$/;\1/g" "$FILE"
  fi
done

#restart fpm
echo 'Restart fpm ...'
PHP_VERSION=$(php -v | grep '^PHP ' | sed -E "s/^PHP ([0-9]\.[0-9]).*$/\1/")
service php"$PHP_VERSION"-fpm restart 2> /dev/null
service php-fpm restart 2> /dev/null

#restart apache
echo 'Restart apache ...'
service apache2 restart 2> /dev/null

#restart on MAC
echo 'Restart brew php ...'
brew services restart php@"$PHP_VERSION" 2> /dev/null

