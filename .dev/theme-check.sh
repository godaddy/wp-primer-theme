#!/bin/bash

set -e
shopt -s expand_aliases
source "$DEV_LIB_PATH/check-diff.sh"

set_environment_variables

DB_NAME=wordpress
DB_USER=root
DB_PASS=''
DB_HOST=localhost

install_wp && install_db

cd ${WP_CORE_DIR}/src

php /tmp/wp-cli.phar config create \
	--dbname=${DB_NAME} \
	--dbuser=${DB_USER} \
	--dbpass=${DB_PASS} \
	--dbhost=${DB_HOST}

php /tmp/wp-cli.phar core install \
	--url=http://tests.dev \
	--title="WordPress Site" \
	--admin_user=admin \
	--admin_password=password \
	--admin_email=admin@tests.dev \
	--skip-email

export INSTALL_PATH=${WP_CORE_DIR}/src/wp-content/themes/${WP_THEME}
mkdir -p ${INSTALL_PATH}
rsync -av --exclude-from ${TRAVIS_BUILD_DIR}/.distignore --delete ${TRAVIS_BUILD_DIR}/ ${INSTALL_PATH}/

php /tmp/wp-cli.phar package install anhskohbo/wp-cli-themecheck
php /tmp/wp-cli.phar plugin install theme-check --activate
php /tmp/wp-cli.phar themecheck --theme=${WP_THEME} --no-interactive
