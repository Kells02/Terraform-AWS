# --Balanceo de carga--

# 1. Cremos el target group
resource "aws_lb_target_group" "my_target_group" {
  name        = "my-target-group"
  port        = 80 // Puerto que escucha wp
  protocol    = "HTTP" // Protocolo
  vpc_id      = aws_vpc.vpc.id // Indicamos la VPC
  target_type = "instance" // instance

  health_check { // Verifica el estado de las instancias wordpress
    healthy_threshold   = 2 // Cantidad de comprobaciones
    interval            = 30 // Intervalo de tiempo entre cada comprobación
    protocol            = "HTTP" // El protocolo para realizar la comprobación
    path                = "/" // Ruta de la solicitud del balanceador (Donde está instalado wp)
    timeout             = 5 // Tiempo máximo que el balanceador de carga espera a que se complete la solicitud
    unhealthy_threshold = 2 // Cantidad de comprobaciones que deben fallar antes de que considere que las instancias están en mal estado
  }
}

# 2. Creamos el balanceo de carga
resource "aws_lb" "wordpress" { // Creamos el balanceo
  depends_on = [ aws_lb_target_group.my_target_group ]
  name               = "wordpress"
  internal           = false // Lo queremeos externo (Da direcciones IP públicas)
  load_balancer_type = "application" // A nivel de aplicación
  subnets            = [aws_subnet.public-subnet-1.id, aws_subnet.public-subnet-2.id] // Hay que poner las subredes públicas
  security_groups    = [aws_security_group.balanceo.id] // Grupo de seguridad del balanceo
}

# 3. Cremos el listener del balanceo de carga
resource "aws_lb_listener" "my_listener" {
  depends_on = [ aws_lb.wordpress ]
  load_balancer_arn = aws_lb.wordpress.arn // Indicamos el balanceo de carga
  port              = "80" // Puerto por el que va escuchar
  protocol          = "HTTP" // Protocolo

  default_action {
    type             = "forward" // Redirigir
    target_group_arn = aws_lb_target_group.my_target_group.arn // Indicamos el target group
  }
}

# 4. Asociamos la instáncia wp1 al target group
resource "aws_lb_target_group_attachment" "wp1" {
  target_group_arn = aws_lb_target_group.my_target_group.arn // Indicamos el target group
  target_id        = aws_instance.wordpress1.id // Indicamos la instáncia wp1
  port = 80 // Puerto de escucha
}

# 4.5 Asociamos la instáncia wp2 al target group
resource "aws_lb_target_group_attachment" "wp2" {
  target_group_arn = aws_lb_target_group.my_target_group.arn // Indicamos el target group
  target_id        = aws_instance.wordpress2.id // Indicamos la instáncia wp2
  port = 80 // Puerto de escucha
}