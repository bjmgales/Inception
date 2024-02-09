# !/bin/sh
mysql_install_db
service mysql start;
mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
echo "$SQL_DATABASE set";
mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"
echo "$SQL_USER set";
mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
echo "$SQL_USER privilege granted";
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
echo "root password $SQL_ROOT_PASSWORD set";
mysql -e "FLUSH PRIVILEGES;"
echo "Refreshing mysql";
echo "$SQL_ROOT_PASSWORD" | mysqladmin -u root -p shutdown
/etc/init.d/mysql stop
exec "$@"

