#!/bin/bash
# Adding php wrapper
user="$1"
domain="$2"
ip="$3"
home_dir="$4"
docroot="$5"

wrapper_script="#!/bin/sh
PHPRC=/usr/local/lib
export PHPRC
export PHP_FCGI_MAX_REQUESTS=1000
export PHP_FCGI_CHILDREN=4
exec  /usr/bin/php-cgi7.0
"
wrapper_file="$home_dir/$user/web/$domain/cgi-bin/fcgi7.0"

echo "$wrapper_script" > $wrapper_file
chown $user:$user $wrapper_file
chmod -f 751 $wrapper_file

exit 0