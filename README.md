<h1>SkyForge</h1>

<p>El proyecto consiste en desplegar una infraestructura en la nube utilizando Terraform en el proveedor de servicios AWS. A través de la automatización de la infraestructura, nuestro objetivo es crear una plataforma escalable, flexible y altamente disponible para alojar múltiples instancias WordPress.</p>

<p>La infraestructura implementada incluye una VPC con subredes públicas y privadas distribuidas en diferentes zonas de disponibilidad. Además, he configurado un clúster de base de datos. Para garantizar la conectividad a las instancias de WordPress ubicadas en subredes privadas, he implementado puertas de enlace NAT y un host bastión en las subredes públicas.</p>

<p>Para garantizar la disponibilidad y el rendimiento, he utilizado un balanceo de carga de aplicaciones que distribuye tráfico entre las instancias de WordPress. Además, he implementado el escalado automático, lo que nos permite ajustar automáticamente la capacidad de la instancia según la carga de trabajo.</p>

<p>En resumen, este proyecto nos permite crear una infraestructura automatizada en AWS, proporcionando una sólida y base escalable para alojar nuestras instancias de WordPress. Ofrece flexibilidad, alta disponibilidad y la capacidad de adaptarse a los cambios en la demanda, asegurando una experiencia de usuario óptima.</p>

<div align="center">
  <img src="https://github.com/Kells02/Terraform-AWS/assets/101474487/4fe46b91-c1eb-4e36-9a44-fa023900a3ee" width="700" alt="Terraform - AWS">
</div>

<h2>I. Terraform: Infraestructura como código</h2>

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

<h3>i. Como funciona Terraform?</h3>

<p>Terraform crea y administra recursos en plataformas en la nube y otros servicios a través de sus interfaces de programación de aplicaciones (API). Los proveedores permiten que Terraform funcione con prácticamente cualquier plataforma o servicio con una API accesible.</p>

<div align="center">
   <img src="https://github.com/Kells02/Terraform-AWS/assets/101474487/fdc13baf-aa63-4ccf-8b05-1f0dd6a72e6f" width="700">
</div>

<p>El flujo de trabajo de Terraform consta de tres etapas:</p>
<b><li>Escribir:</b> Se definen los recursos, que pueden estar en múltiples proveedores y servicios en el nube. Por ejemplo, podemos crear una configuración para implementar una aplicación en máquinas virtuales en una red de nube privada virtual (VPC) con grupos de seguridad y un balanceo de carga.</li>
<b><li>Planificación (Plan):</b> Terraform crea un plan de ejecución que describe la infraestructura que va a crear, actualizará o destruirá en función de la infraestructura existente y su configuración.</li>
<b><li>Aprobación (Apply):</b> Tras la aprobación, Terraform realiza las operaciones propuestas en el orden correcto, respetando las dependencias de los recursos. Por ejemplo, si actualizamos las propiedades de una VPC y cambiamos la cantidad de máquinas virtuales en esta VPC, Terraform volverá a crear la VPC antes de escalar las máquinas virtuales.</li><br>



<h3>ii. Proveedores en Terraform</h3>

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

<h2>II. AWS como proveedor</h2>

<p>En este proyecto, he utilizado AWS como proveedor de servicios en el nube. AWS (Amazon Web Services) es una plataforma líder en la nube que ofrece una amplia gama de servicios y recursos para la implementación, administración y escalado de aplicaciones y servicios en entornos en la nube.</p>

<p>AWS proporciona una infraestructura escalable, de confianza y segura, lo que la convierte en una elección popular para muchas organizaciones y proyectos. Algunos de los servicios más utilizados de AWS incluyen Amazon EC2 (Elastic Compute Cloud) para la creación y administración de instancias de servidores virtuales, Amazon S3 (Simple Storage Service) para el almacenamiento de objetos, Amazon RDS (Relational Database Service) para bases de datos gestionadas, y Amazon ELB (Elastic Load Balanced) para el balanceo de carga.</p>

<p>He elegido AWS como proveedor ya que tiene una amplia gama de servicios y una gran madurez como plataforma en la nube. AWS nos brinda la flexibilidad necesaria para implementar y gestionar nuestra infraestructura de forma eficiente y segura.</p>

<div align="center">
   <img src="https://github.com/Kells02/Terraform-AWS/assets/101474487/641893e0-1ff1-43e4-abd8-592a651d9a3e" width="700">
</div>

<h2>III. Infraestructura a desplegar</h2>

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

<h2>IV. Código de la infraestructura</h2>

<h3>i. Configuraciones basicas</h3>

<p>Ante todo hemos creado el archivo <b>“versiones.tf”</b>, en el que indicamos que versiones queremos utilizar tanto para en Terraform como para el provider.</p>

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
