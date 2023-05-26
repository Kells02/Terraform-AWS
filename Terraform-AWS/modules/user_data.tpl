#!/bin/bash
# Instalador automático de Wordpress en AWS Amazon Linux2

# 1. Indicamos las variables para la conexión a la bd. Las variables se completarán con la plantilla que hemos configurado anteriormente en (instances.tf)
db_username=${db_username} # Usuario de la base de datos
db_user_password=${db_user_password} # Contraseña de la base de datos
db_name=${db_name} # Nombre de la base de datos
db_RDS=${db_RDS} # Endpoint de la base de datos

# 2. Instalación LAMP Server (Linux / Apache / Mysql / PHP)
yum update -y
yum install -y httpd # Instalamos Apache
yum install -y mysql # Instalamos el cliente mysql
amazon-linux-extras enable php7.4 # Habilitamos php7.4
yum clean metadata # Limpiamos los metadatos almacenamso en caché
yum install -y php php-{pear,cgi,common,curl,mbstring,gd,mysqlnd,gettext,bcmath,json,xml,fpm,intl,zip,imap,devel,mysqli} # Instalamos PHP y sus extensiones
yum -y install gcc ImageMagick ImageMagick-devel ImageMagick-perl # Instalamos más paquetes necesarios
pecl install imagick # Instalamos imagick y se crea un archivo de confiuración en "20-imagick.ini"
chmod 755 /usr/lib64/php/modules/imagick.so # Cambiamos los permisos del archivo a "755"
cat <<EOF >>/etc/php.d/20-imagick.ini # Añadimos la configuración necesaria para cargar la extensión  Imagick en PHP
extension=imagick
EOF
systemctl restart php-fpm.service # Reiniciamos PHP
systemctl start httpd # Iniciamos Apache

# 3. Cambiamos propietario y permisos del directorio /var/www
usermod -a -G apache ec2-user # Agregamos el usuario "ec2-user" al grupo "apache" 
chown -R ec2-user:apache /var/www # Cambiamos el propietario y el grupo de todos los archivos y directorios de "/var/www" al usuario "ec2-user" y al grupo "apache"
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
chown -R ec2-user:apache /var/www/html # Cambiamos el propietario a "ec2-user" y el grupo a "apache" al directorio "/var/www/html" y a todos sus archivos y subdirectorios de forma recursiva.
chmod -R 774 /var/www/html # Cambiamos los permisos a "774" (El propietario y el grupo tiene permisos de lectura,escrituar y ejecución, mientras que otros usuarios solo tiene permiso de lectura y ejecución).

# 6. Habilitamos los archivos .htaccess en la configuración de Apache
sed -i '/<Directory "\/var\/www\/html">/,/<\/Directory>/ s/AllowOverride None/AllowOverride all/' /etc/httpd/conf/httpd.conf

# 7. Reiniciamos Apache
systemctl enable  httpd.service # Habilitamos el servicio de Apache para que se inicie automáticamente en el arranque del sistema
systemctl restart httpd.service # Reiniciamos Apache