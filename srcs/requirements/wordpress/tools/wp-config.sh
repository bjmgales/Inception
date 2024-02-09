if [ -f /var/www/wordpress/wp-config.php ]
then
	echo "wordpress already downloaded"
else

####### MANDATORY PART ##########

	wget http://wordpress.org/latest.tar.gz
	tar xfz latest.tar.gz
	rm -rf latest.tar.gz
	sed -i "s/username_here/$SQL_USER/g" ../../../wordpress/wp-config-sample.php
	sed -i "s/password_here/$SQL_PASSWORD/g" ../../../wordpress/wp-config-sample.php
	sed -i "s/localhost/$SQL_HOSTNAME/g" ../../../wordpress/wp-config-sample.php
	sed -i "s/database_name_here/$SQL_DATABASE/g" ../../../wordpress/wp-config-sample.php
	mv ../../../wordpress/* /var/www/wordpress/
	cp /var/www/wordpress/wp-config-sample.php /var/www/wordpress/wp-config.php
fi

/usr/sbin/php-fpm7.3 -F
