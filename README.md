<h1>SkyForge | Terraform & AWS</h1>

<p>by Cristian Fernández Márquez • ☁️🛠️🚀 · ⚙️💻🌐</p>
<p><b>Licencia: </b><a href="https://creativecommons.org/licenses/by-nc-sa/4.0/">Attribution-NonCommercial-ShareAlike 4.0 International</a></p>
<p><em>"Guiando el flujo desde el código hasta la implementación, cada commit es un paso hacia la eficiencia. Comprometido con la excelencia operativa en el universo DevOps. 🌐🚀 #DevOpsJourney"</em></p>

<h2>Tabla de Contenidos</h2>
<ul>
  <li><a href="#i-introducción-al-proyecto">I. Introducción al Proyecto</a></li>
  <li><a href="#ii-terraform-infraestructura-como-código">II. Terraform: Infraestructura como código</a></li>
  <ul>
    <li><a href="#i-como-funciona-terraform">i. Como funciona Terraform?</a></li>
    <li><a href="#ii-proveedores-en-terraform">ii-proveedores-en-terraform</a></li>
  </ul>
  <li><a href="#iii-aws-como-proveedor">III. AWS como proveedor</a></li>
  <li><a href="#iv-infraestructura-a-desplegar">IV. Infraestructura a desplegar</a></li>
  <li><a href="#v-código-de-la-infraestructura">V. Código de la infraestructura</a></li>
  <ul>
    <li><a href="#i-configuraciones-basicas">i. Como funciona Terraform?</a></li>
    <li><a href="#ii-creación-de-la-vpc">ii. Creación de la VPC</a></li>
    <li><a href="#iii-creación-de-las-subredes-públicas">iii. Creación de las subredes públicas</a></li>
    <li><a href="#iv-creación-de-las-subredes-privadas">iv. Creación de las subredes privadas</a></li>
    <li><a href="#v-creación-de-internet-gateway-y-el-enrutamiento-de-las-subredes-públicas">v. Creación de Internet Gateway y el enrutamiento de las subredes públicas</a></li>
    <li><a href="#vi-creación-de-la-nat-gateway-y-enutameinto-de-las-subredes-privadas">vi. Creación de la NAT Gateway y enutameinto de las subredes privadas</a></li>
    <li><a href="#vii-creación-de-las-instancias">vii. Creación de las Instancias</a></li>
    <li><a href="#viii-creación-de-los-grupos-de-seguridad">viii. Creación de los Grupos de Seguridad</a></li>
    <li><a href="#ix-definición-de-parámetros-ami">ix. Definición de parámetros AMI</a></li>
    <li><a href="#x-instalador-automático-de-wordpress">x. Instalador Automático de Wordpress</a></li>
    <li><a href="#xi-instancias-bastión">xi. Instancias Bastión</a></li>
    <li><a href="#xii-instancias-wordpress">xii. Instancias Wordpress</a></li>
    <li><a href="#xiii-creación-del-clúster">xiii. Creación del Clúster</a></li>
    <li><a href="#xiv-creación-del-balanceo-de-carga">xiv. Creación del Balanceo de Carga</a></li>
    <li><a href="#xv-creación-del-auto-escalado">xv. Creación del Auto Escalado</a></li>
  </ul>
  <li><a href="#vi-conclusión">VI. Conclusión</a></li>
</ul>

<h2 id="i-introducción-al-proyecto">I. Introducción al Proyecto</h2>

<p>El proyecto consiste en desplegar una infraestructura en la nube utilizando Terraform en el proveedor de servicios AWS. A través de la automatización de la infraestructura, nuestro objetivo es crear una plataforma escalable, flexible y altamente disponible para alojar múltiples instancias WordPress.</p>

<p>La infraestructura implementada incluye una VPC con subredes públicas y privadas distribuidas en diferentes zonas de disponibilidad. Además, he configurado un clúster de base de datos. Para garantizar la conectividad a las instancias de WordPress ubicadas en subredes privadas, he implementado puertas de enlace NAT y un host bastión en las subredes públicas.</p>

<p>Para garantizar la disponibilidad y el rendimiento, he utilizado un balanceo de carga de aplicaciones que distribuye tráfico entre las instancias de WordPress. Además, he implementado el escalado automático, lo que nos permite ajustar automáticamente la capacidad de la instancia según la carga de trabajo.</p>

<p>En resumen, este proyecto nos permite crear una infraestructura automatizada en AWS, proporcionando una sólida y base escalable para alojar nuestras instancias de WordPress. Ofrece flexibilidad, alta disponibilidad y la capacidad de adaptarse a los cambios en la demanda, asegurando una experiencia de usuario óptima.</p>

<div align="center">
  <video src="https://github.com/Kells02/Terraform-AWS/assets/101474487/ec54cd1e-a12e-4220-9f59-dde9ed69f446"  alt="Terraform - AWS">
</div>


<h2 id="ii-terraform-infraestructura-como-código">II. Terraform: Infraestructura como código</h2>

<p>Terraform es una herramienta de infraestructura como código desarrollada por HashiCorp. Permite definir y
gestionar la infraestructura utilizando un lenguaje de configuración sencillo y comprensible. En lugar de
realizar tareas manuales y configurar la infraestructura de forma manual a través de la consola
de administración de AWS, Terraform nos brinda la capacidad de describir nuestra infraestructura
deseada en un archivo de configuración. Luego, mediante la ejecución de comandos de Terraform,
podemos crear, modificar y eliminar recursos en la nube de forma automatizada y repetible.
</p>

<p>Terraform es un proyecto código abierto, maduro y con una gran cantidad de personas que colaboran, el
su principal ventaja es que tiene una gran cantidad de providers y esto permite crear infraestructuras
híbridas</p>

<p>Algunas de las ventajas de Terraform son:<p>

<b><li>Automatización y eficiencia:</b> Terraform nos permite definir y desplegar toda nuestra infraestructura con solo unos pocos comandos, lo que ahorra tiempo y esfuerzo en comparación con los métodos manuales.</li>
<b><li>Infraestructura como código:</b> Al describir nuestra infraestructura en archivos de configuración, podemos aplicar los principios de desarrollo de software, como control de versiones, revisión de código y colaboración en equipo. Además, esto nos brinda la capacidad de reproducir y compartir la nuestra infraestructura de forma fácil y consistente.</li>
<b><li>Orquestación y gestión centralizada:</b> Terraform permite gestionar y coordinar múltiples recursos y servicios en distintos proveedores de nube. Podemos definir la arquitectura de nuestra aplicación, incluyendo redes, servidores, bases de datos, balanceo de carga y más, todo en un solo archivo de configuración.</li>
<b><li>Planificación y control:</b> Antes de aplicar los cambios en la infraestructura, Terraform nos permite generar un plan que muestra los recursos que se van a crear, modificar o eliminar. Esto nos brinda visibilidad y control sobre los cambios que se realizarán antes de implementarlos, lo que reduce el riesgo de errores y fallos inesperados.</li>

<div align="center">
   <img src="https://github.com/Kells02/Terraform-AWS/assets/101474487/5eb6338c-4842-4214-816b-f7d1b51599e8" width="700">
</div>

<h3 id="i-como-funciona-terraform">i. Como funciona Terraform?</h3>

<p>Terraform crea y administra recursos en plataformas en la nube y otros servicios a través de sus interfaces de programación de aplicaciones (API). Los proveedores permiten que Terraform funcione con prácticamente cualquier plataforma o servicio con una API accesible.</p>

<div align="center">
   <img src="https://github.com/Kells02/Terraform-AWS/assets/101474487/fdc13baf-aa63-4ccf-8b05-1f0dd6a72e6f" width="700">
</div>

<p>El flujo de trabajo de Terraform consta de tres etapas:</p>
<b><li>Escribir:</b> Se definen los recursos, que pueden estar en múltiples proveedores y servicios en el nube. Por ejemplo, podemos crear una configuración para implementar una aplicación en máquinas virtuales en una red de nube privada virtual (VPC) con grupos de seguridad y un balanceo de carga.</li>
<b><li>Planificación (Plan):</b> Terraform crea un plan de ejecución que describe la infraestructura que va a crear, actualizará o destruirá en función de la infraestructura existente y su configuración.</li>
<b><li>Aprobación (Apply):</b> Tras la aprobación, Terraform realiza las operaciones propuestas en el orden correcto, respetando las dependencias de los recursos. Por ejemplo, si actualizamos las propiedades de una VPC y cambiamos la cantidad de máquinas virtuales en esta VPC, Terraform volverá a crear la VPC antes de escalar las máquinas virtuales.</li><br>



<h3 id="ii-proveedores-en-terraform">ii. Proveedores en Terraform</h3>

<p>En Terraform, los proveedores son componentes fundamentales que permiten la interacción con distintos
servicios en la nube, proveedores de infraestructura o plataformas de gestión de recursos. Un proveedor
en Terraform actúa como un complemento que facilita la comunicación y la gestión de recursos específicos
un determinado proveedor.
Cada proveedor tiene su propio conjunto de recursos y configuraciones que se pueden utilizar en los
archivos de configuración de Terraform. Estos recursos representan los elementos de infraestructura
que se pueden crear, modificar o eliminar utilizando Terraform.
Los proveedores en Terraform se encargan de la autenticación, la comunicación con la API del
proveedor y la gestión de los recursos correspondientes. Algunos ejemplos populares de proveedores
en Terraform incluyen AWS, Azure, Google Cloud Platform, DigitalOcean, entre otros.</p>

<div align="center">
   <img src="https://github.com/Kells02/Terraform-AWS/assets/101474487/b2b5bccf-f8af-4b61-be12-90367c473745" width="700">
</div>

<h2 id="iii-aws-como-proveedor">III. AWS como proveedor</h2>

<p>En este proyecto, he utilizado AWS como proveedor de servicios en el nube. AWS (Amazon Web Services) es una plataforma líder en la nube que ofrece una amplia gama de servicios y recursos para la implementación, administración y escalado de aplicaciones y servicios en entornos en la nube.</p>

<p>AWS proporciona una infraestructura escalable, de confianza y segura, lo que la convierte en una elección popular para muchas organizaciones y proyectos. Algunos de los servicios más utilizados de AWS incluyen Amazon EC2 (Elastic Compute Cloud) para la creación y administración de instancias de servidores virtuales, Amazon S3 (Simple Storage Service) para el almacenamiento de objetos, Amazon RDS (Relational Database Service) para bases de datos gestionadas, y Amazon ELB (Elastic Load Balanced) para el balanceo de carga.</p>

<p>He elegido AWS como proveedor ya que tiene una amplia gama de servicios y una gran madurez como plataforma en la nube. AWS nos brinda la flexibilidad necesaria para implementar y gestionar nuestra infraestructura de forma eficiente y segura.</p>

<div align="center">
   <img src="https://github.com/Kells02/Terraform-AWS/assets/101474487/641893e0-1ff1-43e4-abd8-592a651d9a3e" width="700">
</div>

<h2 id="iv-requisitos-previos">IV. Requisitos Previos</h2>
<p>Antes de adentrarnos en el proyecto, tenemos que tener los siguientes requisitos:</p>

<ul>
  <li>Tener instalado Terraform en tu máquina local.</li>
  <li>Tener instalado AWS CLI en tu máquina local.</li>
  <li>Tener instalado Visual Studio Code en tu máquina local.</li>
  <li>Tener instalado Putty en tu máquina local.</li>
  <li>Configuración de AWS CLI.</li>
  <p>Escribimos <b>“aws configure”</b> en la terminal y añadimos la clave de acceso de nuestra cuenta de AWS, clave de acceso secreta, la región y el tipo de formato.</p>
  
  ```shell
  C:\Users\Cristian\Desktop> aws configure
  AWS Access Key ID [None]:  AKIAYERA2MSHZAYLKAUL       
  AWS Secret Access Key [None]: XXXXXXXXXXXXXXXXXXXXXX
  Default region name [None]: eu-west-1
  Default output format [None]: json
  ```
  <li>Clave SSH y conversión a .ppk.</li>
  <p>Para generar la clave SSH de las máquinas tenemos que realizar este comando en la terminal.</p>

  ```shell
  C:\Users\Cristian\Desktop>ssh-keygen -f mykey-pair
  Generating public/private rsa key pair.
  mykey-pair already exists.
  Overwrite (y/n)? y
  Enter passphrase (empty for no passphrase):
  Enter same passphrase again:
  Your identification has been saved in mykey-pair.
  Your public key has been saved in mykey-pair.pub.
  The key fingerprint is:
  SHA256:xHZmIltXFy7Z/xU28VEW5EuxH7HIQ5PRZzIMpMoYmVU cristian@DESKTOP-Q2N5RAE
  The key's randomart image is:
  +---[RSA 3072]----+
  |        ..E.+*BO=|
  |       =   oo*Bo@|
  |      = * * o+o&o|
  |       X B   .+.*|
  |      o S      .+|
  |                o|
  |                .|
  |                 |
  |                 |
  +----[SHA256]-----+
  ```
  <p>Primero de todo abrimos Putty Key Generator y seleccionamos la opción <b>"load"</b>.</p>
  <div align="center">
   <img src="https://github.com/Kells02/Terraform-AWS/assets/101474487/513d734d-5124-45ca-b21f-c8b216d47727" width="400">
  </div>
  
  <p>A continuación seleccionamos la clave privada generada anteriormente.</p>
  <div align="center">
   <img src="https://github.com/Kells02/Terraform-AWS/assets/101474487/a1aba79a-a5e2-4a91-9b5b-6c5a057df604" width="400">
  </div>

  <p>Por último seleccionamos la opción <b>“save private key”</b> y le ponemos el formato <b>".ppk”</b>.</p>
  <div align="center">
   <img src="https://github.com/Kells02/Terraform-AWS/assets/101474487/ceae2ac6-b04b-40e0-8a9b-1149bfe8e98d" width="400">
  </div>
</ul>

<h2 id="iv-infraestructura-a-desplegar">IV. Infraestructura a desplegar</h2>

<p>La infraestructura desplegada consiste en una arquitectura basada en la nube utilizando Amazon Web Services (AWS) como proveedor de servicios. El objetivo principal es crear una infraestructura escalable, segura y de alta disponibilidad para alojar varios WordPress.</p>

<div align="center">
   <img src="https://github.com/Kells02/Terraform-AWS/assets/101474487/d6ad5066-f8c1-4147-b044-1d7149275104" width="700">
</div>

<p>La infraestructura se compone de los siguientes elementos principales:</p>
<b><li>Red y conectividad:</b> La infraestructura se desplegará en la región N.Virginia (us-east-1) de AWS. Esta región específica ofrece una amplia gama de servicios y capacidades de AWS, lo que la convierte en una elección adecuada para nuestro proyecto. 

Dentro de la región N.Virginia, crearemos una Virtual Private Cloud (VPC) para la infraestructura. Una VPC es un servicio de red aislado y personalizable que nos permite lanzar recursos de AWS deforma virtual en una red virtual dedicada.

Para nuestra VPC, asignaremos el rango de dirección IP 30.0.0.0/16.

La VPC, constará de 2 subredes públicas y 4 privadas en las zonas de disponibilidad, la mitad de ellas en “us-east-1a” y la otra en “us-east-1b”.</li>

<p>Tener la infraestructura en diversas zonas de disponibilidad nos ofrece los siguientes beneficios:</p>
<b><ul><ul><li>Alta disponibilidad:</b> Tener recursos replicados en múltiples zonas de disponibilidad, si una zona experimenta una interrupción o falla, los servicios y aplicaciones pueden seguir funcionando en otras zonas sin interrupciones. Esto garantiza una mayor disponibilidad y reduce el impacto de posibles fallos.</li>
<b><li>Tolerancia a fallos:</b> La distribución de la infraestructura en múltiples zonas de disponibilidad proporciona resiliencia y capacidad de recuperación. Si una zona se ve afectada por un fallo, los recursos pueden redirigirse automáticamente a las zonas restantes, evitando la pérdida de datos y minimizando el tiempo de inactividad.</li></ul>

<div align="center">
   <img src="https://github.com/Kells02/Terraform-AWS/assets/101474487/6cd40e83-3fc2-4591-8eea-8f182ce9af5d" width="500">
</div>

<p>Las subredes públicas estarán configuradas para tener conectividad a Internet y permitir el acceso desde y hacia Internet.

También, las subredes públicas tendrán un host bastión. Este host bastión actuó como un punto de entrada seguro desde una red externa y permite a los administradores acceder de forma controlada a los recursos internos. Al configurar un host bastión, añadimos seguridad y establecemos un nivel adicional de protección para nuestra infraestructura.</p>

<div align="center">
   <img src="https://github.com/Kells02/Terraform-AWS/assets/101474487/4fe0cb74-df88-4971-82b7-7bbf79a84b71" width="500">
</div>

<p>Por otra parte, nuestras subredes públicas tendrán una NAT Gateway (Network Address Translation). Estos recursos actuarán como intermediarios para permitir que las subredes donde estarán las instancias Wordpress accedan a recursos externos en Internet de forma segura y controlada.
  
La configuración de NAT nos proporciona la capacidad de filtrar y controlar el tráfico saliente desde las nuestras subredes privadas, garantizando así la seguridad y el acceso adecuado a los servicios externos</p>

<div align="center">
   <img src="https://github.com/Kells02/Terraform-AWS/assets/101474487/ad5a5143-8448-4e16-8b2a-36735622a53a" width="500">
</div>

<p>Las subredes privadas donde correrán las bases de datos, estarán aisladas de Internet ya que no necesitan acceso directo a Internet. De esta forma no exponemos las bases de datos a amenazas externas.

Para garantizar la conectividad dentro de la VPC y entre las subredes, se configurarán tablas de encaminamiento y grupos de seguridad. Las tablas de encaminamiento definen cómo se enrutan los paquetes de red dentro de la VPC, asegurando que los recursos de las diferentes subredes puedan comunicarse entre sí según sea necesario.

Los grupos de seguridad actuarán como firewalls virtuales, controlando el tráfico de red entrante y saliente para nuestros recursos y garantizando un entorno seguro</p>

<b><li>Base de datos:</b> Dentro de nuestra infraestructura, desplegaremos un clúster de bases de datos con 2 nodos basado en el enfoque “Master-Slave” utilizando Amazon Aurora.

Un cluster “Master-Slave” consiste en un nodo principal (Master) y uno o más nodos secundarios (Slaves) que están interconectados y trabajan en conjunto para brindar una mayor disponibilidad, escalabilidad y rendimiento en nuestra aplicación.

Por otra parte, Amazon Aurora es un servicio de base de datos relacional de alto rendimiento.

Amazon Aurora se basa en el motor de base de datos MySQL y ofrece un rendimiento y escalabilidad mejorados en comparación con una base de datos MySQL tradicional. Utiliza una arquitectura de almacenamiento distribuido y replicación automática de datos para garantizar la durabilidad y disponibilidad de los datos.

El nodo Master actuará como punto central de control y gestión del clúster. Es responsable de coordinar y distribuir las tareas entre los nodos esclavos, así como de mantener la coherencia y consistencia de los datos. El nodo Master también es el encargado de manejar las solicitudes de escritura y asegurarse de que se repliquen correctamente en los nodos esclavos.

Por otro lado, el nodo escalau es una réplica del nodo Master y está diseñado para manejar solicitudes de sólo lectura. Este nodo se sincronizará con el nodo Master y mantendrá una copia actualizada de los datos.

La arquitectura de cluster “Master-Slave” ofrece varias ventajas. En primer lugar, proporciona alta disponibilidad, ya que si el nodo Master experimenta algún problema, uno de los nodos Slaves puede asumir el rol de Master y garantizar la continuidad del servicio. Esto asegura que nuestra aplicación esté siempre disponible incluso en caso de fallos.</li>

<div align="center">
   <img src="https://github.com/Kells02/Terraform-AWS/assets/101474487/04ce556c-45c1-409b-b83b-dcaf570fc8b2" width="500">
</div>

<b><li>Balanceo de carga:</b> También implementaremos un balanceo de carga para distribuir el tráfico entrando de forma eficiente entre nuestras instancias de WordPress.

El balanceo de carga actuará como un punto de entrada centralizado y distribuirá las solicitudes de los usuarios entre las instancias disponibles, lo que garantizará una distribución equitativa de la carga de trabajo y mejorará la capacidad de respuesta del sistema.</li>

<div align="center">
   <img src="https://github.com/Kells02/Terraform-AWS/assets/101474487/bd404879-eb49-4f32-aed9-a5b41e3e7f72" width="500">
</div>

<b><li>Auto Escalado:</b> Por último se implementará la funcionalidad de auto escalado utilizando AWS Auto Scaling en las 2 subredes privadas donde se desplegarán los Wordpress. El auto escalado nos permite ajustar automáticamente la capacidad de nuestras instancias de WordPress en función de la carga de trabajo y la demanda del sistema, garantizando así un rendimiento óptimo y una alta disponibilidad.</li>

<div align="center">
   <img src="https://github.com/Kells02/Terraform-AWS/assets/101474487/eb82b2bc-c2d8-4755-819d-b50f66d3f7fb" width="500">
</div>

<h2 id="v-código-de-la-infraestructura">V. Código de la infraestructura</h2>

<h3 id="i-configuraciones-basicas">i. Configuraciones basicas</h3>

<p>Primero de todo hemos creado el archivo <b>“versiones.tf”</b>, en el que indicamos que versiones queremos utilizar tanto para en Terraform como para el provider.</p>

```hcl
# --Configuración Terraform--

terraform {
  required_version = ">= 1.0" // Indicamos la versión mínima requerida
  required_providers {
    aws = {
      source  = "hashicorp/aws" // Indicamos el proveedor
      version = "~> 3.0" // Indicamos la versión mínima del proveedor
    }
  }
}
```
<p>Este código contiene dos secciones principales: <b>terraform</b> y <b>required_providers</b>.

En la seccion <b>terraform</b>, se especifica que se requiere una versión de Terraform igual o superior a la versión 1.0. Indicamos esto para asegurarnos de que el archivo de configuración se ejecute correctamente en la versión correcta de Terraform.

La seccion <b>required_providers</b> especifica los proveedores de Terraform necesarios para el archivo de configuración. En ese caso, se requiere el proveedor de AWS de HashiCorp, que es responsable de interactuar con los recursos de AWS. Indicamos la versión mínima del proveedor, en cuyo caso, "~> 3.0" indica que se requiere una versión igual o superior a 3.0, pero inferior a la versión 4.0.

Estas configuraciones nos aseguran que el archivo de configuración se ejecute correctamente en la versión de Terraform adecuada y que se utilice el proveedor de AWS en la versión mínima requerida.

Por otro lado he creado el archivo <b>“variables.tf”</b> donde están definidas todas las variables que se utilizarán en el archivo de configuración de terraformo. Estas variables permiten parametrizar y personalizar diferentes aspectos del despliegue de la infraestructura.</p>

```hcl
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
variable "root_volume_size" {} // Tamaño de almacenamiento para Wordpress
```
<p>A continuación en el archivo <b>“module.tf”</b> hemos creado el modulo “aws_wordpress” en el que hemos especificado el contenido de cada variable.</p>

```hcl
# --Parámetros--

module aws_wordpress {
    access_key = "(Tu clave pública)" // Clave de acceso pública a la cuenta de AWS
    secret_key = "(Tu clave privada)" // Clave de acceso privada a la cuenta de AWS
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
```
<p>El archivo <b>“provider.tf”</b> nos permite realizar la integración y empezar a utilizar el proveedor de AWS, el primero que debemos hacer es definir las siguientes variables.</p>

```hcl
# --Definimos el proveedor (AWS)--

provider "aws" {
  region     = var.region // Region (us-east-1)
  access_key = var.access_key // Clave de acceso pública a la cuenta de AWS
  secret_key = var.secret_key // Clave de acceso privada a la cuenta de AWS
}
```
<b><li>provider:</b> Indicamos que se utilizará el proveedor "aws".
<b><li>region:</b> Especificamos la región de AWS en la que se desplegarán los recursos. En este caso, se utiliza la variable “var.region” para definir la región, su valor es “us-east-1”.
<b><li>access_key</b> y <b>secret_key:</b> Son las claves de acceso pública y privada a la cuenta de AWS. Éstas claves se obtienen desde las variables “var.access_key” y “var.secret_key”.
<p>Al establecer el proveedor "aws" con la región y las claves de acceso adecuadas, Terraform podrá autenticarse en la cuenta de AWS y realizar operaciones en los recursos definidos en el archivo de configuración.</p>
<p>A continuación, ya podemos empezar a crear los recursos para nuestra infraestructura.</p>

<h3 id="ii-creación-de-la-vpc">ii. Creación de la VPC</h3>

<p>Primero debemos saber que es una VPC; Una VPC es una red virtual aislada que permite lanzar recursos en AWS.</p>
<p>Primero de todo definiremos la VPC (Virtual Private Cloud) y las subredes dentro de ella que utilizaremos en la nuestra infraestructura.</p>
<p>Para ello hemos creado el archivo <b>"vpc-subnets.tf"</b> para definir todos los recursos para la red.</p>
<p>Nuestra infraestructura contará con una VPC y un total de 6 subredes como hemos comentado anteriormente.</p>
<p>A continuación definimos la creación de la VPC.</p>

```hcl
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
```
<p>La VPC está configurada para que su bloque de direcciones IP sea de 30.0.0.0/16. Por otra parte hemos habilitado el soporte para DNS en la VPC, lo que permite que los recursos dentro de la VPC tengan nombres de dominio internos y puedan resolver nombres de dominio.</p>
<p>También hemos habilitado la opción “enable_dns_hostnames” el cual nos permite que los recursos dentro de la VPC tengan nombres de host internos.</p>
<p>Por último hemos dejado por defecto el parámetro “instance_tenancy”, el valor "default" indica que las instancias se ejecutarán en hardware compartido. Esto significa que múltiples instancias de diferentes clientes podrían compartir el mismo hardware físico subyacente en el centro de datos de AWS.</p>
<p>En un entorno de hardware compartido, AWS es responsable de administrar y asignar los recursos de hardware adecuado para garantizar un rendimiento y seguridad óptimos para las instancias. Esto permite a AWS utilizar de forma eficiente los recursos físicos y reducir los costes, ya que múltiples clientes pueden compartir el mismo hardware sin comprometer el aislamiento y la seguridad de los datos.</p>

<h3 id="iii-creación-de-las-subredes-públicas">iii. Creación de las subredes públicas</h3>

<p>Nuestra infraestructura cuenta con 2 subredes públicas. Cada una de las subredes públicas cuentan con un host bastión que posteriormente crearemos y también tendrán una Nat Gateway que darán salida a Internet en las subredes privadas.</p>
<p>A continuación definimos la primera subred pública.</p>

```hcl
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
```
<p>Ante todo hemos definido que este recurso dependa de la VPC, a continuación hemos asociado la subred con la VPC definida anteriormente.</p>
<p>La red de esta subred es 30.0.1.0/24 y se encuentra en la región us-east-1a.</p>
<p>A continuación definimos la segunda subred pública.</p>

```hcl
# 3. Creamos la Subred Pública-2 para Bastion-2
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
```
<p>La configuración es muy similar a la primera subred, pero la red de esta subred es la 30.0.2.0/24 y se encuentra en una región distinta, en us-east-1b.</p>

<h3 id="iv-creación-de-las-subredes-privadas">iv. Creación de las subredes privadas</h3>

<p>A continuación definiremos las 4 subredes privadas que desplegaremos. Dos de las subredes serán dedicadas a web y las otras dos a un cluster de base de datos.</p>
<p>Definimos la primera subred privada para nuestro primer Wordpress.</p>

```hcl
# 4. Creamos la Subred Privada-1 para Wordpress-1
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
```
<p>La red de esta subred es 30.0.3.0/24, definimos que se encuentre en us-east-1a.</p>
<p>Segunda subred privada para el segundo Wordpress.</p>

```hcl
# 5. Creamos la Subred Privada-2 para Wordpress-2
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
```
<p>La red de la segunda subred privada es 30.0.4.0/24, definimos que se encuentre en us-east-1b.</p>
<p>Tercera subred privada para una de las bases de datos.</p>

```hcl
# 6. Creamos la Subred Privada-1 para RDS-1
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
```
<p>La red de la tercera subred privada es 30.0.5.0/24, definimos que se encuentre en us-east-1a.</p>
<p>Última subred privada para la segunda base de datos.</p>

```hcl
# 7. Creamos la Subred Privada-2 para RDS-2
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
```
<p>La red de la cuarta subred privada es 30.0.6.0/24, definimos que se encuentre en us-east-1b.</p>

<h3 id="v-creación-de-internet-gateway-y-el-enrutamiento-de-las-subredes-públicas">v. Creación de Internet Gateway y el enrutamiento de las subredes públicas</h3>
<p>En este apartado se crea una Internet Gateway (puerta de enlace de Internet) para permitir el acceso a Internet desde la VPC.</p>
<p>Internet Gateway actúa como un punto de conexión entre la VPC e Internet. Permite que los recursos dentro de la VPC accedan a Internet y también permite el tráfico de entrada desde Internet hacia los recursos de la VPC, según las reglas de seguridad y encaminamiento configuradas.</p>
<p>A continuación definimos la Internet Gateway.</p>

```hcl
# 8. Gateway Subred Pública (Creamos el Gateway para poder tener acceso a Internet)
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id // Indicamos la VPC
  tags = {
    Name = "Internet Gateway - Public & Private VPC"
  }
}
```
<p>En el següent codi definim una taula de rutes per a la subxarxa pública. La taula de rutes especifica com s’enruta el trànsit dins de la VPC i cap a fora d'ella, i en aquest cas es configura per a permetre l'accés a Internet.</p>

```hcl
# 9. (Definimos la tabla de rutas para la subred pública, especificamos la puerta de enlace de Internet)
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
```
<p>Aquesta configuració assegura que tot el trànsit destinat a adreces IP externes (0.0.0.0/0) es dirigeixi a la Internet Gateway, la qual cosa permet que les instàncies en la subxarxa pública accedeixin a Internet.</p>

```hcl
#  10. Asociar Route Table a la Subred Pública-1
// (Asociamos la tabla de enrutamiento a la subred pública-1 para darle la puerta de enlace de Internet)
resource "aws_route_table_association" "rt-association1" {
  subnet_id      = aws_subnet.public-subnet-1.id // Indicamos la subred pública-1
  route_table_id = aws_route_table.public-rt.id // Indicamos la tabla de rutas
}

#  10.5 Asociar Route Table a la Subred Pública-2
// (Asociamos la tabla de enrutamiento a la subred pública-2 para darle la puerta de enlace de Internet)
resource "aws_route_table_association" "rt-association2" {
  subnet_id      = aws_subnet.public-subnet-2.id // Indicamos la subred pública-2
  route_table_id = aws_route_table.public-rt.id // Indicamos la tabla de rutas
}
```
<p>Estas asociaciones aseguran que las subredes públicas utilicen la tabla de rutas correcta, la que contiene la ruta hacia Internet Gateway. De esta forma, las instancias en las subredes públicas pueden enviar y recibir tráfico hacia y desde Internet.</p>

<h3 id="vi-creación-de-la-nat-gateway-y-enutameinto-de-las-subredes-privadas">vi. Creación de la NAT Gateway y enutameinto de las subredes privadas</h3>
<p>A continuación hemos creado la primera NAT Gateway con una IP elástica asociada a la subred pública-1. La NAT Gateway permite que las instancias en las subredes privadas se conecten a Internet saliendo a través de la NAT Gateway. La IP elástica asegura que la dirección IP de la NAT Gateway no cambie, lo que es importante para establecer conexiones de salida de confianza.</p>

```hcl
// --------------------- NAT 1 --------------------------------
# 11. Creamos una IP elástica para la NAT Gateway-1
resource "aws_eip" "Nat-Gateway-1" {
  depends_on = [aws_route_table_association.rt-association1, aws_route_table_association.rt-association2]
  vpc = true
}

# 11.5 Creamos la NAT Gateway-1
resource "aws_nat_gateway" "NAT_GATEWAY-1" {
  depends_on = [aws_eip.Nat-Gateway-1]
  allocation_id = aws_eip.Nat-Gateway-1.id # Asociamos la IP elástica con la NAT Gateway-1
  subnet_id = aws_subnet.public-subnet-1.id # Asociamos a la subred públcia-1
  tags = {
    Name = "Nat-Gateway_1"
  }
}
```
<p>En este fragmento de código se configura y crea una tabla de rutas específica para NAT Gateway 1, así como la asociación entre esta tabla de rutas y la primera subred privada.</p>

```hcl
# 12. Creamos la tabla de rutas para la NAT Gateway-1
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

# 13. Creamos la asociación entre la tabla de rutas y la NAT Gateway-1 
resource "aws_route_table_association" "Nat-Gateway-RT-Association-1" {
  depends_on = [aws_route_table.NAT-Gateway-RT-1]
  subnet_id      = aws_subnet.private-subnet-wp-1.id // Subred privada wp-1
  route_table_id = aws_route_table.NAT-Gateway-RT-1.id // Tabla de rutas NAT-1
}
```
<p>En resum, aquest codi crea una taula de rutes dedicada per a la NAT Gateway-1, que permet l'encaminament del trànsit cap a la NAT Gateway-1 per a la seva sortida a Internet. A més, s'estableix l'associació entre aquesta taula de rutes i la primera subxarxa privada, la qual cosa assegura que el trànsit de sortida d'aquesta subxarxa passi a través de la NAT Gateway-1.</p>
<p>A continuació creem la segona NAT Gateway amb una IP elàstica associada a la segona subxarxa privada.</p>

```hcl
// --------------------- NAT 2 --------------------------------
# 14. Creamos una IP elástica para la NAT Gateway-2
resource "aws_eip" "Nat-Gateway-2" {
  depends_on = [aws_route_table_association.rt-association1, aws_route_table_association.rt-association2]
  vpc = true
}

# 14.5 Creamos la NAT Gateway-2
resource "aws_nat_gateway" "NAT_GATEWAY-2" {
  depends_on = [aws_eip.Nat-Gateway-2]
  allocation_id = aws_eip.Nat-Gateway-2.id # Asociamos la IP elástica con la NAT Gateway-1
  subnet_id = aws_subnet.public-subnet-2.id # Asociamos a la subred públcia-1
  tags = {
    Name = "Nat-Gateway_2"
  }
}
```
<p>Configuramos y creamos una mesa de rutas para la segunda NAT Gateway y se realiza la asociación con la segunda subred privada.</p>

```hcl
# 15. Creamos la tabla de rutas para la NAT Gateway-2
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

# 16. Creamos la asociación entre la tabla de rutas y la NAT Gateway-1 
resource "aws_route_table_association" "Nat-Gateway-RT-Association-2" {
  depends_on = [aws_route_table.NAT-Gateway-RT-2]
  subnet_id      = aws_subnet.private-subnet-wp-2.id // Subred privada wp-2
  route_table_id = aws_route_table.NAT-Gateway-RT-2.id // Tabla de rutas NAT-2
}
```
<p>En resumen, este código crea una tabla de rutas específica para la NAT Gateway-2, permitiendo que el tráfico de salida de la subred privada wp-2 pase a través de la NAT Gateway-2. Esto asegura la conectividad a Internet para los recursos situados en esta subred privada.</p>

<h3 id="vii-creación-de-las-instancias">vii. Creación de las Instancias</h3>
<p>Antes de empezar a crear las instancias se ha requerido crear las claves de acceso para acceder a ellas remotamente, como hemos comentado anteriormente.</p>
<p>Antes de definir las instancias hemos definido un recurso en <b>“instances.tf”</b> que nos permite importar la clave pública generada anteriormente, para su uso en las instancias.</p>

```hcl
# --Instancias--

# 1. Importamos la clave para las instancias
resource "aws_key_pair" "mykey-pair" {
  key_name   = var.key_name // Nombre de la clave
  public_key = file(var.PUBLIC_KEY_PATH) // Clave pública
}
```
<p>Además, se ha requerido crear varios archivos previos: “security-groups.tf”, “aws_ami”, “user_data.tpl” y "user_data_ubuntu.tpl".</p>
<b><li>security-groups.tf:</b> Este archivo define los grupos de seguridad que utilizaremos en la infraestructura.</li>
<b><li>aws_ami.tf:</b> Este archivo define los parámetros de las AMI (Amazon Machine Image) que utilizaremos para crear las instancias.</li>
<b></li>user_data.tpl:</b> Script de instalación automática y configuración de Wordpress para instancias Amazon Linux.</li>
<b><li>user_data_ubuntu.tpl:</b> Script de instalación y configuración automática de Wordpress para instancias Ubuntu.</li>

<h3 id="viii-creación-de-los-grupos-de-seguridad">viii. Creación de los Grupos de Seguridad</h3>
<p>Los grupos de seguridad ayudan a proteger y controlar el tráfico de red dentro de la infraestructura de AWS, garantizando que sólo se permitan las conexiones necesarias y restringiendo el acceso no autorizado.</p>
<p>Hemos creado el archivo <b>“security-groups.tf”</b> en el que hemos definido todos los grupos de seguridad necesarios para nuestra infraestructura.</p>
<p>A continuación, hemos definido el grupo de seguridad para las instancias bastión.</p>

```hcl
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
```
<p>Este grupo de seguridad permite todo el tráfico. Permite cualquier tipo de conexión de entrada y salida.</p>
<p>Actúa como un punto de entrada seguro para acceder a otros recursos en la red.</p>
<p>También se ha definido el grupo de seguridad para las instancias Wordpress.</p>

```hcl
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
```
<p>Este grupo de seguridad permite el tráfico específico necesario para ejecutar un servidor Wordpress.</p>
<p>Permite conexiones HTTP (puerto 80), HTTPS (puerto 443), MySQL (puerto 3306) y SSH (puerto 22) desde cualquier dirección IP. Además permite todo el tráfico de salida.</p>
<p>Definimos el grupo de seguridad para la base de datos.</p>

```hcl
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
```
<p>Este grupo de seguridad se utiliza para controlar el acceso al cluster de base de datos de Amazon RDS (Relational Database Service). Sólo permite conexiones MySQL (puerto 3306) desde instancias que tengan el grupo de seguridad "aws_security_group.wordpress.id", que es el grupo de seguridad de Wordpress definido anteriormente. Permite todo el tráfico de salida.</p>
<p>A continuación definimos el último grupo de seguridad. El grupo de seguridad para el balanceo de carga.</p>

```hcl
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
```
<p>Este grupo de seguridad permite conexiones HTTP (puerto 80), HTTPS (puerto 443) desde cualquier dirección IP. Además permite todo el tráfico de salida.</p>
<p>Por último se define un grupo de subred para las bases de datos.</p>

```hcl
# 5. Crear grupo de subred RDS
resource "aws_db_subnet_group" "RDS_subnet_grp" {
  subnet_ids = ["${aws_subnet.private-subnet-rds-1.id}", "${aws_subnet.private-subnet-rds-2.id}"] // Indicamos las subredes donde estarán las bases de datos
}
```
<p>Especificamos las subredes privadas de las bases de datos. Esto es necesario para configurar correctamente el cluster en la red.</p>

<h3 id="ix-definición-de-parámetros-ami">ix. Definición de parámetros AMI</h3>
<p>Como hemos mencionado anteriormente, podemos realizar la instalación de Wordpress en una instancia Ubuntu o Amazon Linux. Por eso, hemos creado el archivo <b>“aws_ami.tf”</b> para definir los parámetros de cada uno. Estas AMIs se utilizarán más adelante en la configuración para crear instancias de EC2 con las imágenes correctas.</p>

<p>A continuación podemos ver la configuración de ese archivo.</p>
<p>Primero de todo hemos definido los parámetros de la AMI de Amazon Linux.</p>

```hcl
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
```
<p>Hemos indicado que queremos la versión más reciente de la AMI. Por otra parte, especificamos que queremos la siguiente AMI <b>“amzn2-ami-hvm-*-x86_64-gp2”</b> y que la AMI utilice <b>“HVM”</b> como tipo de visualización.</p>
<p>También queremos que la AMI sea oficial por Amazon.</p>
<p>Por otra parte, hemos definido los parámetros de la AMI de Ubuntu.</p>

```hcl
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
```
<p>Hemos indicado que queremos la versión más reciente de la AMI. Por otro lado, especificamos que queremos la siguiente AMI <b>“ubuntu-focal-20.04-amd64-server-*”</b> y que la AMI utilice <b>“HVM”</b> como tipo de visualización.</p>

<h3 id="x-instalador-automático-de-wordpress">x. Instalador Automático de Wordpress</h3>
<p>Para la instalación de Wordpress hemos creado dos archivos: <b>“user_data.tpl”</b> y <b>“user_data_ubuntu.tpl”</b>.</p>
<p>El archivo <b>“user_data.tpl”</b> esta configurado para realizar la instalación para una instancia Amazon Linux, en cambio el archivo <b>“user_data_ubuntu.tpl”</b> esta configurado para realizar la instalación para una instancia Ubuntu.</p>
<p>A continuación podemos ver la configuración del archivo <b>“user_data_ubuntu.tpl”</b>.</p>

```tpl
#!/bin/bash
# Instalador automático de Wordpress en AWS Ubuntu Server 20.04 LTS (HVM)

# 1. Indicamos las variables para la conexión a la bd. Las variables se completarán con la plantilla que hemos configurado anteriormente en (instances.tf)
db_username=${db_username} # Usuario de la base de datos
db_user_password=${db_user_password} # Contraseña de la base de datos
db_name=${db_name} # Nombre de la base de datos
db_RDS=${db_RDS} # Endpoint de la base de datos
```
<p>Primero de todo definimos las variables para la conexión a la base de datos. Al ser un archivo <b>“.tpl”</b>, nos permite asignar las variables desde una plantilla externa que comentaré posteriormente.</p>
<p>A continuación instalamos LAMP Server (Linux/Apache/MySQL/PHP).</p>

```tpl
# 2. Instalación LAMP Server (Linux / Apache / Mysql / PHP)
apt update  -y
apt upgrade -y
apt update  -y
apt upgrade -y
apt install -y apache2 # Instalamos Apache Server
apt install -y php # Instalamos PHP
apt install -y php php-{pear,cgi,common,curl,mbstring,gd,mysqlnd,bcmath,json,xml,intl,zip,imap,imagick,mysqli} # Instalamos paquetes necesarios para PHP
apt install -y mysql-client-core-8.0 # Instalamos el cliente mysql
systemctl enable --now  apache2 # Iniciamos Apache y registramos para el inicio
```
<p>El siguiente paso es cambiar el propietario y los permisos en el directorio “/var/www”.</p>

```tpl
# 3. Cambiamos propietario y permisos del directorio /var/www
usermod -a -G www-data ubuntu # Añadimos el usuario "ubuntu" al grupo "www-data"
chown -R ubuntu:www-data /var/www # Cambiamos el propietario y grupo de todos los archivos y directorios dentro de "/var/www" al usuario "ubuntu" y al grupo "www-data"
find /var/www -type d -exec chmod 2775 {} \; # Buscamos todos los directorios dentro de "/var/www" y establecemos el permiso "2775" (Permiso completo para acceder y modificar los archivos en los directorios, usuarios tienen permiso de lectura y ejecución)
find /var/www -type f -exec chmod 0664 {} \; # Buscamos todos los archivos dentro de "/var/www" y establecemos el permiso "0664" (Permiso completo de lectura y escritura en los archivos, el grupo tiene permiso de lectura y escritura, los ususarios permiso de lectura)
```
<p>En el cuarto paso instalamos Wordpress mediante WP CLI.</p>

```tpl
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
```
<p>Finalmente cambiamos los permisos en “/var/www/html”, habilitamos los archivos “.htaccess” y reiniciamos.</p>

```tpl
# 5. Cambiamos permisos en "/var/www/html"
chown -R ubuntu:www-data /var/www/html # Cambiamos el propietario a "ubuntu" y el grupo a "www-data" al directorio "/var/www/html" y a todos sus archivos y subdirectorios de forma recursiva.
chmod -R 774 /var/www/html # Cambiamos los permisos a "774" (El propietario y el grupo tiene permisos de lectura,escrituar y ejecución, mientras que otros usuarios solo tiene permiso de lectura y ejecución).
rm /var/www/html/index.html # Eliminamos el archivo "index.html" que viene por defecto por Apache

# 6. Habilitamos los archivos .htaccess en la configuración de Apache
sed -i '/<Directory \/var\/www\/>/,/<\/Directory>/ s/AllowOverride None/AllowOverride all/' /etc/apache2/apache2.conf
a2enmod rewrite # Habilitamos el módulo "rewrite" de Apache. Es necesario para que las reglas de reescritura de URL funcionen en WordPress.

# 7. Reiniciamos Apache
systemctl restart apache2 # Reiniciamos el servicio de Apache
```
<h3 id="xi-instancias-bastión">xi. Instancias Bastión</h3>
<p>Como hemos comentado anteriormente, las instancias bastión actúan como un punto de entrada seguro y controlado para acceder a otros servidores en una red privada, proporcionando una capa adicional de seguridad y control en la administración de sistemas.</p>
<p>Para la creación del primer host bastión, hemos definido 3 recursos:</p>
<b><li>Creación de la interfaz de red (aws_network_interface):</b> Creamos una interfaz llamada “bastion1”, indicamos la primera subred pública, asignamos una IP privada a la interfaz "30.0.1.50" y especificamos que utilice el grupo de seguridad bastión.</li>

```hcl
# 2.(Bastion-1). Creamos una interfaz de red con una IP estática del rango de la IP pública
resource "aws_network_interface" "bastion1" {
  subnet_id = aws_subnet.public-subnet-1.id // ID subnet pública
  private_ips = ["30.0.1.50"] // IP Privada
  security_groups = ["${aws_security_group.bastion.id}"] // Grupo de seguridad Bastion
}
```
<b><li>Asignación de una IP elástica a la interfaz de red (aws_eip):</b> Creamos una dirección IP elástica y la asociamos con la interfaz de red “bastion1”. Indicamos que utilizamos la IP privada "30.0.1.50".</li>

```hcl
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
```
<b><li>Creación de la instancia del primer host bastión (aws_instance):</b> Indicamos la AMI que utilizaremos (Ubuntu), el tipo de instancia (t2.micro), la clave pública y asignamos la interfaz de red.</li>

```hcl
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
```
<p>A continuación creamos los mismos recursos para el segundo host bastión.</p>
<p>Creamos la interfaz de red, en este caso indicamos que esta instancia se encuentre en la segunda subred pública, indicamos la IP privada "30.0.2.50" y su grupo de seguridad.</p>

```hcl
# 4. (Bastion-2). Creamos una interfaz de red con una IP estática del rango de la IP pública
resource "aws_network_interface" "bastion2" {
  subnet_id = aws_subnet.public-subnet-2.id // ID subnet pública-2
  private_ips = ["30.0.2.50"] // IP Privada
  security_groups = ["${aws_security_group.bastion.id}"] // Grupo de seguridad Bastion
}
```
<p>Asignamos una IP elástica a la interfaz del segundo host bastión junto con la IP privada "30.0.2.50".</p>

```hcl
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
```
<p>A continuación creamos la instancia. Indicamos la AMI (Ubuntu), el tipo de instancia (t2.micro), la clave pública y asignamos su interfaz de red.</p>

```hcl
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
```
<p>Finalmente hemos creado dos recursos “null_resource”, que nos permiten copiar las claves privadas hacia las dos instancias bastión. De esta forma los host bastión podrán hacer SSH hacia las instancias que se encuentren en las subredes privadas.</p>

```hcl
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
```
<h3 id="xii-instancias-wordpress">xii. Instancias Wordpress</h3>
<p>Antes de definir ambas instancias Wordpress, hemos definido el recurso <b>“data.template_file”</b>. Éste recurso nos permite definir un archivo de datos de usuario, que variará según la AMI utilizada (Ubuntu o Amazon Linux). En la especificamos las variables necesarias para el archivo de datos de el usuario, como el nombre de la base de datos, contraseña de la base de datos, nombre del usuario y el endpoint para poder realizar la conexión. Estos son los datos que se traspasan a los archivos <b>“.tpl”</b>, que hemos comentado anteriormente.</p>

```hcl
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
```
<p>A continuación creamos ambas instancias Wordpress.</p>
<p>Para la primera instancia hemos indicado la AMI Ubuntu por defecto, el tipo de instancia (t2.micro), el script con la instalación de Wordpress, la clave pública, la subred en este caso la primera subred privada, el grupo de seguridad Wordpress, asignamos una dirección privada "30.0.3.50" y el tamaño del volumen raíz de almacenamiento de la instancia.</p>

```hcl
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
```
<p>Creem la segona instància Wordpress.</p>
<p>Fem la mateixa configuració, però canviem la subxarxa per la segona subxarxa privada amb la IP privada “30.0.3.50”.</p>

```hcl
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
```
<p>Com hem comentat abans aquestes instàncies sortiran a Internet mitjançant les NAT Gateways configurades anteriorment.</p>

<h3 id="xiii-creación-del-clúster">xiii. Creación del Clúster</h3>
<p>Hemos definido un cluster mediante el servicio RDS (Relational Dtabase Service) de AWS en el archivo <b>“database.tf”</b>.</p>
<p>A continuación, podemos ver cómo hemos definido el recurso <b>“aws_rds_clúster”</b> para la creación del clúster.</p>

```hcl
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
```
<p>Hemos indicado el motor de la base de datos (aurora-mysql), la versión del motor de la base de datos, nombre de la base de datos, usuario, contraseña, el período de retención de copias de seguridad, la ventana de tiempo preferida para realizar las copias de seguridad, la ventana de tiempo preferida por a realizar tareas de mantenimiento, indicamos su grupo de seguridad y el grupo de subred creado anteriormente.</p>
<p>Por otra parte, creamos el primer nodo. Este nodo es el máster.</p>

```hcl
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
```
<p>Indicamos el clúster que pertenece, el tipo de instancia (db.r3.large), el motor de la base de datos (aurora-mysql), indicamos que no sea accesible públicamente y le decimos el grupo de subredes al que pertenece.</p>
<p>Por último creamos el segundo nodo. Este nodo es el esclavo. Su configuración es muy similar a primer nodo.</p>

```hcl
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
```
<p>Establecemos los mismos valores que el nodo1. En este caso indicamos que dependa del nodo1. Cómo podemos ver no es necesario indicarle si es el nodo maestro o esclavo ya que al crearse después del nodo1, AWS ya da por supuesto que es el nodo esclavo.</p>

<h3 id="xiv-creación-del-balanceo-de-carga">xiv. Creación del Balanceo de Carga</h3>
<p>Hemos creado un balanceo de carga en el archivo <b>“balanceador.tf”</b>, ya que es una estrategia clave para mejorar el rendimiento, la disponibilidad y la escalabilidad de las aplicaciones y servicios. Permite distribuir la carga de trabajo de forma equitativa, mejorar el tiempo de respuesta, garantizar la disponibilidad continua y facilitar la gestión del tráfico.</p>
<p>Ante todo hemos tenido que definir un target group (grupo objetivo). Un target group representa un grupo lógico de destinos a los que se dirigen las solicitudes entrantes desde el balanceador de carga. Cada target group está asociado a un balanceador de carga y define las instancias o destinos a los que se debe enrutar el tráfico de forma equitativa y eficiente.</p>

```hcl
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
```
<p>Hemos indicado el puerto por el que escuchará las solicitudes entrantes en este caso el puerto 80, el protocolo HTTP, VPC y el tipo de destino que en este caso nos referimos a las instancias.</p>
<p>Por otro lado tenemos el blog <b>"health_check"</b>. En este blog hemos definido la configuración de verificación estado de las instancias Wordpress.</p>
<p>Hemos especificado el número de comprobaciones consecutivas que deben ser exitosas para que una instancia se marque como saludable, en este caso un total de 2, un intervalo de 30 segundos entre cada comprobación de estado, el protocolo HTTP por donde se realizará la comprobación, la ruta de la solicitud que se utiliza para la comprobación de estado, en este caso, se utiliza "/" para verificar la ruta raíz del servicio Wordpress, el tiempo máximo en segundos que el balanceador de carga espera que se complete una solicitud antes de considerarla como quiebra y finalmente el número de comprobaciones consecutivas que deben fallar para que una instancia se marque como no saludable.</p>
<p>A continuación hemos definido el balanceo de carga.</p>

```hcl
# 2. Creamos el balanceo de carga
resource "aws_lb" "wordpress" { // Creamos el balanceo
  depends_on = [ aws_lb_target_group.my_target_group ]
  name               = "wordpress"
  internal           = false // Lo queremeos externo (Da direcciones IP públicas)
  load_balancer_type = "application" // A nivel de aplicación
  subnets            = [aws_subnet.public-subnet-1.id, aws_subnet.public-subnet-2.id] // Hay que poner las subredes públicas
  security_groups    = [aws_security_group.balanceo.id] // Grupo de seguridad del balanceo
}
```
<p>Indicamos que nuestro balanceo de carga sea externo, es decir que tendrá direcciones IP públicas.</p>
<p>Especificamos que queremos un balanceo de carga de tipo aplicación, lo que indica que opera en nivel de aplicación y es capaz de dirigir las solicitudes con rutas distintas a destinos diferentes. Finalmente indicamos las subredes en las que se desplegará el balanceo de carga, en este caso las dos subredes públicas e indicamos su grupo de seguridad.</p>
<p>También hemos definido un listenero para el balanceo de carga. El listener sirve como un intermediario entre el tráfico entrante y los destinos configurados, asegurando que las solicitudes se distribuyan de manera eficiente y equilibrada, mejorando la disponibilidad, escalabilidad y rendimiento de las aplicaciones o servicios desplegados en la infraestructura.</p>

```hcl
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
```
<p>Como podemos ver hemos indicado el balanceo de carga, el puerto 80 es por donde escuchara las solicitudes entrantes junto el protocolo HTTP. Finalmente hemos configurado el listener para que las solicitudes recibidas sean reenviadas al target group asociado.</p>
<p>Por último, asociamos las instancias wordpress previamente definidas en el target group.</p>

```hcl
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
```
<h3 id="xv-creación-del-auto-escalado">xv. Creación del Auto Escalado</h3>
<p>También hemos definido un acto escalado en el archivo <b>“auto scaling.tf”</b>, puesto que nos permite ajustar automáticamente la capacidad de recursos de computación en función de la demanda de aplicación.</p>
<p>A continuación podemos ver la configuración de la instancia de lanzamiento para el escalado automático. La configuración de lanzamiento se utiliza como base para crear nuevas instancias cuando se requiere escalar automáticamente el número de instancias en función de la carga o política de escalado definida.</p>

```hcl
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
```
<p>Hemos indicado la AMI (Ubuntu), el tipo de instancia (t2.micro), la clave pública, el script con la instalación de Wordpress y el grupo de seguridad Wordpress.</p>
<p>También hemos definido un grupo de acto escalado. Un grupo de acto escalado es un conjunto de instancias que pueden escalarse automáticamente según la demanda de la aplicación.</p>

```hcl
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
```
<p>Hemos especificado el número mínimo de instancias que se mantendrán activas en el grupo a 1, el número máximo a 2 y la capacidad deseada a 2. Indicamos la configuración de las instancias que hemos definido anteriormente, las subredes privadas donde se lanzarán estas instancias, el target group, el tipo de comprobación de salud que se realizará en las instancias del grupo de acto escalado y el período de gracia en segundos antes de que el grupo de acto escalado inicie la comprobación de salud después de lanzar una instancia, en este caso 300 segundos.</p>
<p>Por último, creamos una política de escalado automático.</p>

```hcl
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
```
<p>Hemos definido que el grupo de autoo escalado debe ajustar automáticamente el número de instancias en función de una métrica objetivo. En este caso, la métrica objetivo es el uso de CPU, estableciéndose un valor objetivo del 75%. Si el uso de CPU supera este valor, se crearán nuevas instancias automáticamente en el grupo de acto escalado.</p>

<h2 id="vi-conclusión">VI. Conclusión</h2>
<p>En conclusión, el despliegue automatizado de esta infraestructura en la nube utilizando Terraform y AWS nos ha permitido crear un entorno altamente disponible, escalable y flexible para a alojar nuestros sitios de WordPress. Mediante la configuración de una VPC, subredes, balanceo de carga, autoescalado y clúster de base de datos, hemos logrado establecer una infraestructura robusta que puede adaptarse a las necesidades cambiantes.</p>
<p>Aquest projecte ens ha brindat nombrosos beneficis, com la capacitat d'escalar automàticament les nostres instàncies de WordPress segons la demanda, garantint una experiència òptima per als usuaris. A més, hem assegurat l'alta disponibilitat i la tolerància a fallades en distribuir les nostres instàncies en diferents zones de disponibilitat i en implementar mecanismes de connectivitat redundant.</p>
<p>La utilización de Terraform nos ha permitido gestionar y mantener fácilmente nuestra infraestructura como a código, lo que facilita la replicación del entorno en diferentes etapas de desarrollo y en otros regiones de AWS si es necesario. Asimismo, hemos aprovechado las ventajas de AWS como proveedor de servicios en la nube, beneficiándonos de su amplia gama de servicios y su escalabilidad.</p>
<p>En resumen, este proyecto ha demostrado el valor de la automatización y la infraestructura como código en la creación de una arquitectura cloud robusta y adaptable. Hemos aprendido a escalar una posible infraestructura de forma eficiente y brindar un servicio de confianza a nuestros usuarios.</p>

<hr>
<p><a href="https://github.com/Kells02/Terraform-AWS">SkyForge | Terraform & AWS</a></p>
<p>by Cristian Fernández Márquez está licenciado bajo <a href="https://creativecommons.org/licenses/by-nc-sa/4.0/">Attribution-NonCommercial-ShareAlike 4.0 International</a></p>

<div align="center">
   <img src="https://github.com/Kells02/Terraform-AWS/assets/101474487/6c96958c-e1a9-484b-ab07-0b0a5a94eda6" width="200">
</div>
