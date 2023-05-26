# --Base de datos--

# 1. Creamos el cluster
resource "aws_rds_cluster" "wordpressdb-cluster" {
  cluster_identifier   = "wordpress-cluster"
  engine               = var.engine // Motor de la base de datos (aurora-mysql)
  engine_version       = var.engine_version // Versión del motor de la base de datos (5.7.mysql_aurora.2.07.1)
  database_name        = var.database_name // Nombre de la DB (wordpress_db)
  master_username      = var.database_user // Usuario de la DB (admin)
  master_password      = var.database_password // Contraseña de la DB (password)
  backup_retention_period = var.backup_retention_period // // Período de retención de copias de seguridad
  preferred_backup_window = var.preferred_backup_window // Indicamos la ventana de tiempo preferida para realizar los backups
  preferred_maintenance_window = var.preferred_maintenance_window // Indicamos la ventana de tiempo preferida para realizar las tareas de mantenimiento
  skip_final_snapshot  = true // Indicamos que no queremos una instantánea del clúster cuando este se elimine
  vpc_security_group_ids = [aws_security_group.RDS_allow_rule.id] // Grupo de seguridad RDS
  db_subnet_group_name   = aws_db_subnet_group.RDS_subnet_grp.id // Grupo de la subred RDS
}

# 2. Creamos el Nodo1 - Master
resource "aws_rds_cluster_instance" "wordpressdb-1" { // Nodo1 - Master (Escritura)
  depends_on = [aws_rds_cluster.wordpressdb-cluster]
  identifier = "master"
  cluster_identifier    = aws_rds_cluster.wordpressdb-cluster.id // Indicamos el cluster
  instance_class        = var.instance_class // Tipo de instáncia (db.r3.large)
  engine                = var.engine // Motor de la base de datos (aurora-mysql)
  publicly_accessible   = false // Indicamos que no sea accesible públicamente. No es accesible desde Internet
  db_subnet_group_name  = aws_db_subnet_group.RDS_subnet_grp.name // Indicamos el grupo de subredes
}

# 3. Creamos el Nodo2 - Slave
resource "aws_rds_cluster_instance" "wordpressdb-2" { // Nodo2 - Slave (Lectura + Réplica)
  depends_on = [aws_rds_cluster_instance.wordpressdb-1]
  identifier = "slave"
  cluster_identifier    = aws_rds_cluster.wordpressdb-cluster.id // Indicamos el cluster
  instance_class        = var.instance_class // Tipo de instáncia (db.r3.large)
  engine                = var.engine // Motor de la base de datos (aurora-mysql)
  publicly_accessible   = false // Indicamos que no sea accesible públicamente. No es accesible desde Internet
  db_subnet_group_name  = aws_db_subnet_group.RDS_subnet_grp.name // Indicamos el grupo de subredes
}