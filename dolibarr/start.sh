#!/bin/bash

set -o pipefail

DOCROOT="/usr/share/dolibarr/htdocs"
DOLICONF="/etc/dolibarr/conf.php"

cat >${DOLICONF}<<EOF
<?php
\$dolibarr_main_url_root='${DOLI_URL_ROOT}';
\$dolibarr_main_document_root='${DOCROOT}';
\$dolibarr_main_url_root_alt='/custom';
\$dolibarr_main_document_root_alt='${DOCROOT}/custom';
\$dolibarr_main_data_root='/var/lib/dolibarr/documents';
\$dolibarr_main_db_host='${DOLI_DB_HOST}';
\$dolibarr_main_db_port='3306';
\$dolibarr_main_db_name='${DOLI_DB_NAME}';
\$dolibarr_main_db_prefix='llx_';
\$dolibarr_main_db_user='${DOLI_DB_USER}';
\$dolibarr_main_db_pass='${DOLI_DB_PASSWORD}';
\$dolibarr_main_db_type='mysqli';
\$dolibarr_main_db_character_set='utf8';
\$dolibarr_main_db_collation='utf8_unicode_ci';
EOF

chown ${APACHE_RUN_USER}:${APACHE_RUN_GROUP} ${DOLICONF}
chmod 400 ${DOLICONF}

cat >/etc/php/7.0/apache2/php.ini<<EOF
log_errors = On
error_log = /dev/stderr
EOF

sed -i -r "s/^Listen.*/Listen ${APACHE_LISTEN_PORT}/" /etc/apache2/ports.conf

exec apache2 -DFOREGROUND
