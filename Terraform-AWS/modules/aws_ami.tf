# --Parámetros AMI--

# 1. AMI Linux
data "aws_ami" "linux2" { // AMI Amazon Linux2
  most_recent = true // Queremos utilizar la última versión

  filter { // Filtros de la AMI
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners      = ["amazon"] // Account del owner
}

# 2. AMI Ubuntu
data "aws_ami" "ubuntu" { // AMI Ubuntu
  most_recent = true // Queremos utilizar la última versión

  filter { // Filtros de la AMI
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] // Account del owner
}