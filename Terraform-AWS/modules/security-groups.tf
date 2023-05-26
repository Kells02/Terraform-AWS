# --Grupos de Seguridad--

# 1. Grupo de Seguridad para Bastion
resource "aws_security_group" "bastion" {
  vpc_id = aws_vpc.vpc.id // Indicamos VPC

  ingress { // Creamos la regla de entrada (Permitimos Todo)
    description = "All trafic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress { // Creamos la regla de salida (Permitimos todo)
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Bastion - allow all trafic"
  }
}

# 2. Grupo de seguridad para Wordpress
resource "aws_security_group" "wordpress" {
  vpc_id = aws_vpc.vpc.id // Indicamos VPC

  ingress { // Creamos la regla de entrada HTTPS
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress { // Creamos la regla de entrada HTTP
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress { // Creamos la regla de entrada MYSQL
    description = "MYSQL"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress { // Creamos la regla de entrada SSH
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress { // Creamos la regla de salida (Permitimos todo)
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Wordpress - allow ssh,http,https"
  }
}

# 3. Grupo de Seguridad para RDS
resource "aws_security_group" "RDS_allow_rule" {
  vpc_id = aws_vpc.vpc.id // Indicamos la VPC
  
  ingress { // Creamos la regla de entrada MYSQL
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = ["${aws_security_group.wordpress.id}"] // Solo le permite la conexión a las instáncias con este grupo de seguridad
  }

  egress { // Creamos la regla de salida (Permitimos todo)
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "RDS - Allow EC2"
  }
}

# 4. Grupo de Seguridad para el Balanceo de Carga
resource "aws_security_group" "balanceo" {
  vpc_id = aws_vpc.vpc.id // Indicamos la VPC
  
  ingress { // Creamos la regla de entrada HTTPS
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress { // Creamos la regla de entrada HTTP
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress { // Creamos la regla de salida (Permitimos todo)
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Balanceo de carga"
  }
}

# 5. Crear grupo de subred RDS
resource "aws_db_subnet_group" "RDS_subnet_grp" {
  subnet_ids = ["${aws_subnet.private-subnet-rds-1.id}", "${aws_subnet.private-subnet-rds-2.id}"] // Indicamos las subredes donde estarán las bases de datos
}