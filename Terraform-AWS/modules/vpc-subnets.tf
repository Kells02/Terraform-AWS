# --VPC & Subredes--

# 1.Creamos VPC (Virtual Private Cloud)
resource "aws_vpc" "vpc" {
  cidr_block           =  var.VPC_cidr // Red IPv4 de la VPC (30.0.0.0/16)
  enable_dns_support   = "true" # Nos da el nombre de dominio interno
  enable_dns_hostnames = "true" # Nos da el hostname interno
  instance_tenancy     = "default"
  tags = {
    Name = "VPC"
  }
}

# 2.Creamos la Subred Pública-1 para Bastion-1
resource "aws_subnet" "public-subnet-1" {
  depends_on = [aws_vpc.vpc]
  vpc_id                  = aws_vpc.vpc.id // Indicamos la VPC
  cidr_block              = var.subnet1_cidr // Red IPv4 de la subred pública-1 (30.0.1.0/24)
  map_public_ip_on_launch = "true" // Hace de esta una subred pública
  availability_zone       = var.AZ1 // Indicamos la region de la subred (us-east-1a)
  tags = {
    Name = "Subred Pública-1"
  }
}

# 4. Creamos la Subred Pública-2 para Bastion-2
resource "aws_subnet" "public-subnet-2" {
  depends_on = [aws_vpc.vpc]
  vpc_id                  = aws_vpc.vpc.id // Indicamos la VPC
  cidr_block              = var.subnet2_cidr // Red IPv4 de la subred pública-2 (30.0.2.0/24)
  map_public_ip_on_launch = "true" // Hace de esta una subred pública
  availability_zone       = var.AZ2 // Indicamos la region de la subred (us-east-1b)
  tags = {
    Name = "Subred Pública-2"
  }
}

# 5. Creamos la Subred Privada-1 para Wordpress-1
resource "aws_subnet" "private-subnet-wp-1" {
  depends_on              = [aws_vpc.vpc]
  vpc_id                  = aws_vpc.vpc.id // Indicamos la VPC
  cidr_block              = var.subnet3_cidr // Red IPv4 de la subred pública-1 (30.0.3.0/24)
  map_public_ip_on_launch = "false" // Hace de esta una subred privada
  availability_zone       = var.AZ1 // Indicamos la region de la subred (us-east-1a)
  tags = {
    Name = "Subred Privada-1 WP"
  }
}

# 6. Creamos la Subred Privada-2 para Wordpress-2
resource "aws_subnet" "private-subnet-wp-2" {
  depends_on              = [aws_vpc.vpc]
  vpc_id                  = aws_vpc.vpc.id // Indicamos la VPC
  cidr_block              = var.subnet4_cidr // Red IPv4 de la subred pública-1 (30.0.4.0/24)
  map_public_ip_on_launch = "false" // Hace de esta una subred privada
  availability_zone       = var.AZ2 // Indicamos la region de la subred (us-east-1b)
  tags = {
    Name = "Subred Privada-2 WP"
  }
}

# 7. Creamos la Subred Privada-1 para RDS-1
resource "aws_subnet" "private-subnet-rds-1" {
  depends_on              = [aws_vpc.vpc]
  vpc_id                  = aws_vpc.vpc.id // Indicamos la VPC
  cidr_block              = var.subnet5_cidr // Red IPv4 de la subred privada-1 (30.0.5.0/24)
  map_public_ip_on_launch = "false" // Hace de esta una subred privada
  availability_zone       = var.AZ1 // Indicamos la region de la subred (us-east-1a)
  tags = {
    Name = "Subred Privada-1 RDS"
  }
}

# 8. Creamos la Subred Privada-2 para RDS-2
resource "aws_subnet" "private-subnet-rds-2" {
  depends_on              = [ aws_vpc.vpc ]
  vpc_id                  = aws_vpc.vpc.id // Indicamos la VPC
  cidr_block              = var.subnet6_cidr // Red IPv4 de la subred privada-2 (30.0.6.0/24)
  map_public_ip_on_launch = "false" // Hace de esta una subred privada
  availability_zone       = var.AZ2 // Indicamos la region de la subred (us-east-1b)
  tags = {
    Name = "Subred Privada-2 RDS"
  }
}

# 9. Gateway Subred Pública (Creamos el Gateway para poder tener acceso a Internet)
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id // Indicamos la VPC
  tags = {
    Name = "Internet Gateway - Public & Private VPC"
  }
}

# 10. (Definimos la tabla de rutas para la subred pública, especificamos la puerta de enlace de Internet)
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.vpc.id // Indicamos la VPC

  route { // Definimos la ruta
    cidr_block = "0.0.0.0/0" // Permitimos el tráfico desde cualquier dirección IP hacia fuera de la VPC
    gateway_id = aws_internet_gateway.igw.id // Indicamos el internet gateway
 }
  tags = {
    Name = "Enrutamiento para Internet Gateway"
  }
}

#  11. Asociar Route Table a la Subred Pública-1
// (Asociamos la tabla de enrutamiento a la subred pública-1 para darle la puerta de enlace de Internet)
resource "aws_route_table_association" "rt-association1" {
  subnet_id      = aws_subnet.public-subnet-1.id // Indicamos la subred pública-1
  route_table_id = aws_route_table.public-rt.id // Indicamos la tabla de rutas
}

#  11.5 Asociar Route Table a la Subred Pública-2
// (Asociamos la tabla de enrutamiento a la subred pública-2 para darle la puerta de enlace de Internet)
resource "aws_route_table_association" "rt-association2" {
  subnet_id      = aws_subnet.public-subnet-2.id // Indicamos la subred pública-2
  route_table_id = aws_route_table.public-rt.id // Indicamos la tabla de rutas
}

// --------------------- NAT 1 --------------------------------
# 12. Creamos una IP elástica para la NAT Gateway-1
resource "aws_eip" "Nat-Gateway-1" {
  depends_on = [aws_route_table_association.rt-association1, aws_route_table_association.rt-association2]
  vpc = true
}

# 12.5 Creamos la NAT Gateway-1
resource "aws_nat_gateway" "NAT_GATEWAY-1" {
  depends_on = [aws_eip.Nat-Gateway-1]
  allocation_id = aws_eip.Nat-Gateway-1.id # Asociamos la IP elástica con la NAT Gateway-1
  subnet_id = aws_subnet.public-subnet-1.id # Asociamos a la subred públcia-1
  tags = {
    Name = "Nat-Gateway_1"
  }
}

# 13. Creamos la tabla de rutas para la NAT Gateway-1
resource "aws_route_table" "NAT-Gateway-RT-1" {
  depends_on = [aws_nat_gateway.NAT_GATEWAY-1]
  vpc_id = aws_vpc.vpc.id // Indicamos la VPC

  route { // Definimos la ruta
    cidr_block = "0.0.0.0/0" // Permitimos el tráfico desde cualquier dirección IP hacia fuera de la VPC
    nat_gateway_id = aws_nat_gateway.NAT_GATEWAY-1.id // Indicamos la NAT Gateway-1
  }
  tags = {
    Name = "Route Table for NAT Gateway-1"
  }
}

# 14. Creamos la asociación entre la tabla de rutas y la NAT Gateway-1 
resource "aws_route_table_association" "Nat-Gateway-RT-Association-1" {
  depends_on = [aws_route_table.NAT-Gateway-RT-1]
  subnet_id      = aws_subnet.private-subnet-wp-1.id // Subred privada wp-1
  route_table_id = aws_route_table.NAT-Gateway-RT-1.id // Tabla de rutas NAT-1
}

// --------------------- NAT 2 --------------------------------
# 15. Creamos una IP elástica para la NAT Gateway-2
resource "aws_eip" "Nat-Gateway-2" {
  depends_on = [aws_route_table_association.rt-association1, aws_route_table_association.rt-association2]
  vpc = true
}

# 15.5 Creamos la NAT Gateway-2
resource "aws_nat_gateway" "NAT_GATEWAY-2" {
  depends_on = [aws_eip.Nat-Gateway-2]
  allocation_id = aws_eip.Nat-Gateway-2.id # Asociamos la IP elástica con la NAT Gateway-1
  subnet_id = aws_subnet.public-subnet-2.id # Asociamos a la subred públcia-1
  tags = {
    Name = "Nat-Gateway_2"
  }
}

# 16. Creamos la tabla de rutas para la NAT Gateway-2
resource "aws_route_table" "NAT-Gateway-RT-2" {
  depends_on = [aws_nat_gateway.NAT_GATEWAY-2]
  vpc_id = aws_vpc.vpc.id // Indicamos la VCP

  route { // Definimos la ruta
    cidr_block = "0.0.0.0/0" // Permitimos el tráfico desde cualquier dirección IP hacia fuera de la VPC
    nat_gateway_id = aws_nat_gateway.NAT_GATEWAY-2.id // Indicamos la NAT Gateway-2
  }
  tags = {
    Name = "Route Table for NAT Gateway-2"
  }
}

# 17. Creamos la asociación entre la tabla de rutas y la NAT Gateway-1 
resource "aws_route_table_association" "Nat-Gateway-RT-Association-2" {
  depends_on = [aws_route_table.NAT-Gateway-RT-2]
  subnet_id      = aws_subnet.private-subnet-wp-2.id // Subred privada wp-2
  route_table_id = aws_route_table.NAT-Gateway-RT-2.id // Tabla de rutas NAT-2
}