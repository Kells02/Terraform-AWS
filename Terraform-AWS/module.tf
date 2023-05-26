# --Parámetros--

module aws_wordpress {
    access_key = "" // Clave de acceso pública a la cuenta de AWS
    secret_key = "" // Clave de acceso privada a la cuenta de AWS
    source            = "./modules/latest"
    database_name     = "wordpress_db"   // Nombre de la base de datos
    database_user     = "admin" // Nombre del usuario de la base de datos
    database_password = "admin12345" // Contraseña de la base de datos
    region            = "us-east-1" // Region en la que desplegaremos la infraestructura
    IsUbuntu          = true // TRUE para ubuntu,FALSE para linux 2
    AZ1          = "us-east-1a" // Zona 1
    AZ2          = "us-east-1b" // Zona 2
    VPC_cidr     = "30.0.0.0/16"     // Red de la VPC 
    subnet1_cidr = "30.0.1.0/24"     // Subred Pública para bastion-1
    subnet2_cidr = "30.0.2.0/24"     // Subred Pública para bastion-2
    subnet3_cidr = "30.0.3.0/24"     // Subred Privada para wordpress-1
    subnet4_cidr = "30.0.4.0/24"     // Subred Privada para wordpress-2
    subnet5_cidr = "30.0.5.0/24"     // Subred Privada para RDS-1
    subnet6_cidr = "30.0.6.0/24"     // Subred Privada para RDS-2
    PUBLIC_KEY_PATH  = "./mykey-pair.pub" // Path de la clave pública
    PRIV_KEY_PATH    = "./mykey-pair"   // Path de la clave privada
    KEY_PUTTY        = "./mykey-pair1.ppk" // Path de la clave para putty
    instance_type    = "t2.micro"    // Tipo de instáncia para Wordpress
    instance_class   = "db.r3.large" // Tipo de instáncia para RDS
    engine           = "aurora-mysql" // Motor de la base de datos
    engine_version   = "5.7.mysql_aurora.2.07.1" // Versión del motor de la base de datos
    backup_retention_period = "7" // Período de retención de copias de seguridad
    preferred_backup_window = "02:00-03:00" // Indicamos la ventana de tiempo preferida para realizar los backups
    preferred_maintenance_window = "sun:05:00-sun:06:00" // Indicamos la ventana de tiempo preferida para realizar las tareas de mantenimiento
    key_name = "my-keypair" // Nombre de la clave
    root_volume_size = 22   // Tamaño de almacenamiento para Wordpress
}