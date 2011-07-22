
dbicadmin -Ilib --schema Domedula::Schema \
 --connect='["dbi:SQLite:dbname=data.db", "", ""]' \
 --deploy

