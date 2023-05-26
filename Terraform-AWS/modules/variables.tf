# --Variables--

variable "database_name" {} // Nombre de la base de datos
variable "database_password" {} // Contraseña de la base de datos
variable "database_user" {} // Usuario de la base de datos
variable "region" {} // Region que vamos a utilizar
variable "access_key" {} // Clave de acceso pública a la cuenta de AWS
variable "secret_key" {} // Clave de acceso privada a la cuenta de AWS
variable "IsUbuntu" { // Indicamos que la instáncia és Ubuntu / Sino será Amazon Linux
  type    = bool
  default = true
}
variable "AZ1" {} // Zona 1
variable "AZ2" {} // Zona 2
variable "VPC_cidr" {} // Red VPC
variable "subnet1_cidr" {} // Subred Bastion-1
variable "subnet2_cidr" {} // Subred Bastion-2
variable "subnet3_cidr" {} // Subred Wordpress-1
variable "subnet4_cidr" {} // Subred Wordpress-2
variable "subnet5_cidr" {} // Subred RDS-1
variable "subnet6_cidr" {} // Subred RDS-2
variable "PUBLIC_KEY_PATH" {} // Path clave pública
variable "PRIV_KEY_PATH" {} // Path clave privada
variable "KEY_PUTTY" {} // Path de la clave para putty
variable "instance_type" {} // Tipo de instáncia Wordpress
variable "instance_class" {} // Tipo de instáncia RDS
variable "engine" {} // Motor de la base de datos
variable "engine_version" {} // Versión del motor de la base de datos
variable "backup_retention_period" {} // Período de retención de copias de seguridad
variable "preferred_backup_window" {} // Indicamos la ventana de tiempo preferida para realizar los backups
variable "preferred_maintenance_window" {} // Indicamos la ventana de tiempo preferida para realizar las tareas de mantenimiento
variable "key_name" {} // Nombre de la clave
variable "root_volume_size" {} // Tamaño de añmacenamiento para Wordpress