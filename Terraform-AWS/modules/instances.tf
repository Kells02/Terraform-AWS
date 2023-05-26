# --Instancias--

# 1. Importamos la clave para las instancias
resource "aws_key_pair" "mykey-pair" {
  key_name   = var.key_name // Nombre de la clave
  public_key = file(var.PUBLIC_KEY_PATH) // Clave pública
}

# 2.(Bastion-1). Creamos una interfaz de red con una IP estática del rango de la IP pública
resource "aws_network_interface" "bastion1" {
  subnet_id = aws_subnet.public-subnet-1.id // ID subnet pública
  private_ips = ["30.0.1.50"] // IP Privada
  security_groups = ["${aws_security_group.bastion.id}"] // Grupo de seguridad Bastion
}

# 2.5 (Bastion-1). Asignamos una IP elastica a la interfaz que hemos creado en el punto
resource "aws_eip" "one" { // Para la Bastion-1
  depends_on = [aws_instance.wordpress1]
  vpc = true
  network_interface = aws_network_interface.bastion1.id // Indicamos la interfaz de red
  associate_with_private_ip = "30.0.1.50" // Asociamos la IP privada
  tags = {
    Name = "Bastion-1"
  }
}

# 3. Creamos la instancia Bastion-1
resource "aws_instance" "bastion1" {
  depends_on    = [aws_subnet.public-subnet-1, aws_key_pair.mykey-pair]
  ami           = var.IsUbuntu ? data.aws_ami.ubuntu.id : data.aws_ami.linux2.id // AMI (ami-0481e8ba7f486bd99)
  instance_type = var.instance_type // Tipo de instancia (t2.micro)
  key_name      = aws_key_pair.mykey-pair.id // Indicamos la clave
  network_interface {
    network_interface_id = aws_network_interface.bastion1.id // Interfaz de red bastion-1
    device_index = 0
  }
  tags = {
    Name = "Bastion-1"
  }
}

# 4. (Bastion-2). Creamos una interfaz de red con una IP estática del rango de la IP pública
resource "aws_network_interface" "bastion2" {
  subnet_id = aws_subnet.public-subnet-2.id // ID subnet pública-2
  private_ips = ["30.0.2.50"] // IP Privada
  security_groups = ["${aws_security_group.bastion.id}"] // Grupo de seguridad Bastion
}

# 4.5 (Bastion-2). Asignamos una IP elastica a la interfaz que hemos creado en el punto
resource "aws_eip" "two" { // Para la Bastion-2
  depends_on = [aws_instance.wordpress2]
  vpc = true
  network_interface = aws_network_interface.bastion2.id // Indicamos la interfaz de red
  associate_with_private_ip = "30.0.2.50" // Asociamos la IP privada
  tags = {
    Name = "Bastion-2"
  }
}

# 4. Creamos la instancia Bastion-2
resource "aws_instance" "bastion2" {
  depends_on    = [aws_subnet.public-subnet-2, aws_key_pair.mykey-pair]
  ami           = var.IsUbuntu ? data.aws_ami.ubuntu.id : data.aws_ami.linux2.id // AMI (ami-0481e8ba7f486bd99)
  instance_type = var.instance_type // Tipo de instancia (t2.micro)
  key_name      = aws_key_pair.mykey-pair.id // Indicamos la clave
  network_interface {
    network_interface_id = aws_network_interface.bastion2.id // Interfaz de red bastion-2
    device_index = 0
  }
  tags = {
    Name = "Bastion-2"
  }
}

# 5. Permite cambiar el valor de la variable USERDATA después de obtener la información del endpoint de RDS
data "template_file" "user_data-1" {
  template = var.IsUbuntu ? file("${path.module}/userdata_ubuntu.tpl") : file("${path.module}/user_data.tpl") // La template varia según la AMI que utilizemos (Por defecto Ubuntu)
  vars = {
    db_username      = var.database_user // Usuario de la base de datos
    db_user_password = var.database_password // Contraseña de la base de datos
    db_name          = var.database_name // Nombre de la base de datos
    db_RDS           = aws_rds_cluster_instance.wordpressdb-1.endpoint // Endpoint del clúster (Dirección de conexión del clúster de base de datos)
  }
}

# 6. Creamos la instáncia Wordpress1
resource "aws_instance" "wordpress1" {
  depends_on      = [aws_rds_cluster_instance.wordpressdb-1] // Se creará después del Nodo-1
  ami             = var.IsUbuntu ? data.aws_ami.ubuntu.id : data.aws_ami.linux2.id // AMI (ami-0481e8ba7f486bd99)
  instance_type   = var.instance_type // Tipo de instáncia (t2.micro)
  user_data       = data.template_file.user_data-1.rendered // Script ejecutable
  key_name        = aws_key_pair.mykey-pair.id // Id clave privada
  subnet_id       = aws_subnet.private-subnet-wp-1.id // Indicamos la subred privada wp-1
  security_groups = ["${aws_security_group.wordpress.id}"] // Indicamos el grupo de seguridad wordpress
  private_ip      = "30.0.3.50" // Asignamos una IP privada a la instáncia
  root_block_device {
    volume_size = var.root_volume_size # Tamaño de almacenamiento en GB (22)
  }
  tags = {
    Name = "Wordpress-1"
  }
}

# 7. Creamos la instáncia Wordpress2
resource "aws_instance" "wordpress2" {
  depends_on      = [aws_rds_cluster_instance.wordpressdb-2, aws_instance.wordpress1] // Se creará después del Nodo-1 y del WP-1
  ami             = var.IsUbuntu ? data.aws_ami.ubuntu.id : data.aws_ami.linux2.id // AMI (ami-0481e8ba7f486bd99)
  instance_type   = var.instance_type // Tipo de instáncia (t2.micro)
  user_data       = data.template_file.user_data-1.rendered // Script ejecutable
  key_name        = aws_key_pair.mykey-pair.id // Id clave privada
  subnet_id       = aws_subnet.private-subnet-wp-2.id // Indicamos la subred privada wp-2
  security_groups = ["${aws_security_group.wordpress.id}"] // Indicamos el grupo de seguridad wordpress
  private_ip      = "30.0.4.50" // Asignamos una IP privada a la instáncia
  root_block_device {
    volume_size = var.root_volume_size # Tamaño de almacenamiento en GB (22)
  }
  tags = {
    Name = "Wordpress-2"
  }
}

# 8. Enviamos la clave a la instáncia bastion-1
resource "null_resource" "copy_file-1" {
  provisioner "local-exec" {
    command = "echo 'y' | pscp -i ${var.KEY_PUTTY} ${var.PRIV_KEY_PATH} ubuntu@${aws_eip.one.public_ip}:/home/ubuntu/" // Utilizamos Putty para enviar la clave
  }
  depends_on = [aws_instance.bastion1]
}

# 9. Enviamos la clave a la instáncia bastion-2
resource "null_resource" "copy_file-2" {
  provisioner "local-exec" {
    command = "echo 'y' | pscp -i ${var.KEY_PUTTY} ${var.PRIV_KEY_PATH} ubuntu@${aws_eip.two.public_ip}:/home/ubuntu/" // Utilizamos Putty para enviar la clave
  }
  depends_on = [aws_instance.bastion2]
}