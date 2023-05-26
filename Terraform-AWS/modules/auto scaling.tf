# --Auto Scaling--

# 1. Configuramos las instáncias del Auto Escalado
resource "aws_launch_configuration" "wordpress" {
  name          = "Wordpress-AutoScaling"
  image_id      = var.IsUbuntu ? data.aws_ami.ubuntu.id : data.aws_ami.linux2.id // AMI (ami-0481e8ba7f486bd99)
  instance_type = var.instance_type // Tipo de instáncia (t2.micro)
  key_name      = aws_key_pair.mykey-pair.id // Indicamos la clave privada
  user_data     = data.template_file.user_data-1.rendered // Script ejecutable
  security_groups = [aws_security_group.wordpress.id] // Grupo de seguridad a asignar a las instáncias
}

# 2. Creamos el grupo de auto scaling
resource "aws_autoscaling_group" "wordpress" {
  name                 = "wordpress-group"
  min_size             = 1 //1 Número mínimo de instáncias
  max_size             = 2 //2 Número máximo de instáncias
  desired_capacity     = 2 //2 Capacidad
  launch_configuration = aws_launch_configuration.wordpress.name // Indicamos la configuración
  vpc_zone_identifier  = [aws_subnet.private-subnet-wp-1.id, aws_subnet.private-subnet-wp-2.id] // Indicamos las subredes privadas donde se crearán las instáncias del auto escalado
  target_group_arns    = ["${aws_lb_target_group.my_target_group.arn}"] // Grupo del balanceo de carga (para que se añadan al balanceador una vez que se creen)
  health_check_type    = "ELB" // Tipo de comprobación de salud a través del balanceador de carga
  health_check_grace_period = 300 // Segudnos antes de que el grupo de auto escalado inicie la comprobación de salud después de que se haya lanzado una instáncia.

  tag {
    key                 = "Name"
    value               = "Wordpress Auto-Scaling" // Nombre Instáncias
    propagate_at_launch = true
  }
}

# 3. Creamos una política de escalado automático
resource "aws_autoscaling_policy" "wordpress" {
  name           = "cpu-scaling-policy"
  policy_type           = "TargetTrackingScaling" // La política ajustará automáticamente el número de instáncias en el grupo de escalado automático para mantener una métrica objetivo específica.
  estimated_instance_warmup = 300 // Indica el tiempo de espera en segundos antes de que una instancia nueva esté completamente operativa para recibir tráfico
  autoscaling_group_name = aws_autoscaling_group.wordpress.name // Indicamos el grupo de auto escalado

  target_tracking_configuration { // Definimos la configuración de seguimiento
      predefined_metric_specification {
        predefined_metric_type = "ASGAverageCPUUtilization" // Miramos el porcentage de CPU utilizado
      }
      target_value = 75 // 75% CPU -> Si superá el 75% creará una o varias instáncias automáticamente
    }
}