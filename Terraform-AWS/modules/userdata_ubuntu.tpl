#!/bin/bash
# Instalador automático de Wordpress en AWS Ubuntu Server 20.04 LTS (HVM)

# 1. Indicamos las variables para la conexión a la bd. Las variables se completarán con la plantilla que hemos configurado anteriormente en (instances.tf)
db_username=${db_username} # Usuario de la base de datos
db_user_password=${db_user_password} # Contraseña de la base de datos
db_name=${db_name} # Nombre de la base de datos
db_RDS=${db_RDS} # Endpoint de la base de datos

# 2. Instalación LAMP Server (Linux / Apache / Mysql / PHP)
apt update  -y
apt upgrade -y
apt update  -y
apt upgrade -y
apt install -y apache2 # Instalamos Apache Server
apt install -y php # Instalamos PHP
apt install -y php php-{pear,cgi,common,curl,mbstring,gd,mysqlnd,bcmath,json,xml,intl,zip,imap,imagick,mysqli} # Instalamos paquetes necesarios para PHP
apt install -y mysql-client-core-8.0 # Instalamos el cliente mysql
systemctl enable --now  apache2 # Iniciamos Apache y registramos para el inicio

# 3. Cambiamos propietario y permisos del directorio /var/www
usermod -a -G www-data ubuntu # Añadimos el usuario "ubuntu" al grupo "www-data"
chown -R ubuntu:www-data /var/www # Cambiamos el propietario y grupo de todos los archivos y directorios dentro de "/var/www" al usuario "ubuntu" y al grupo "www-data"
find /var/www -type d -exec chmod 2775 {} \; # Buscamos todos los directorios dentro de "/var/www" y establecemos el permiso "2775" (Permiso completo para acceder y modificar los archivos en los directorios, usuarios tienen permiso de lectura y ejecución)
find /var/www -type f -exec chmod 0664 {} \; # Buscamos todos los archivos dentro de "/var/www" y establecemos el permiso "0664" (Permiso completo de lectura y escritura en los archivos, el grupo tiene permiso de lectura y escritura, los ususarios permiso de lectura)

# 4. Instalamos Wordpress utilizando WP CLI 
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar # Descargamos wp-cli
chmod +x wp-cli.phar # Añadimos permisos de ejecución al archivo descargado
mv wp-cli.phar /usr/local/bin/wp # Movemos el archivo y lo renombramos como "wp". Ya podemos ejecutar el comando "wp" desde cualquier ubicación del sistema
wp core download --version="latest" --locale="es_ES" --path="/var/www/html" --allow-root # Descargamos la última versión de Wordpress en "español" y lo guardamos en "/var/www/html", permitimos ejecutar el comando como "root"
wp config create --dbname=$db_name --dbuser=$db_username --dbpass=$db_user_password --dbhost=$db_RDS --path="/var/www/html" --allow-root --extra-php # Creamos el archvio de configuración de Wordpress "wp-config.php" con la información de la base de datos proporcioanda. El parámetro --extra-php permite agregar código PHP adicional al archivo de configuración.
wp core install --url=$(curl -s ifconfig.me) --title="WordPress - Cris~Dragos" --admin_user="admin" --admin_password="password" --admin_email="cfernandezm2@ies-sabadell.cat" --path="/var/www/html/" --allow-root # Instalamos Wordpress. Añadimos el título del sitio, nombre de usuario, contraseña, correo.
<<PHP # Agregamos definiciones adicionales al archivo "wp-config.php". Establecemos el método de acceso al sistema de archivos y configuramos el límite de memoria para Wordpress.
define( 'FS_METHOD', 'direct' );
define('WP_MEMORY_LIMIT', '128M');
PHP

# 5. Cambiamos permisos en "/var/www/html"
chown -R ubuntu:www-data /var/www/html # Cambiamos el propietario a "ubuntu" y el grupo a "www-data" al directorio "/var/www/html" y a todos sus archivos y subdirectorios de forma recursiva.
chmod -R 774 /var/www/html # Cambiamos los permisos a "774" (El propietario y el grupo tiene permisos de lectura,escrituar y ejecución, mientras que otros usuarios solo tiene permiso de lectura y ejecución).
rm /var/www/html/index.html # Eliminamos el archivo "index.html" que viene por defecto por Apache

# 6. Habilitamos los archivos .htaccess en la configuración de Apache
sed -i '/<Directory \/var\/www\/>/,/<\/Directory>/ s/AllowOverride None/AllowOverride all/' /etc/apache2/apache2.conf
a2enmod rewrite # Habilitamos el módulo "rewrite" de Apache. Es necesario para que las reglas de reescritura de URL funcionen en WordPress.

# 7. Reiniciamos Apache
systemctl restart apache2 # Reiniciamos el servicio de Apache