<div align="center">
  <img src="https://github.com/Kells02/Terraform-AWS/assets/101474487/4fe46b91-c1eb-4e36-9a44-fa023900a3ee" width="500" alt="Terraform - AWS">
</div>

<h1>SkyForge</h1>

<p>El proyecto consiste en desplegar una infraestructura en la nube utilizando Terraform en el proveedor de servicios AWS. A través de la automatización de la infraestructura, nuestro objetivo es crear una plataforma escalable, flexible y altamente disponible para alojar múltiples instancias WordPress.</p>

<p>La infraestructura implementada incluye una VPC con subredes públicas y privadas distribuidas en diferentes zonas de disponibilidad. Además, he configurado un clúster de base de datos. Para garantizar la conectividad a las instancias de WordPress ubicadas en subredes privadas, he implementado puertas de enlace NAT y un host bastión en las subredes públicas.</p>

<p>Para garantizar la disponibilidad y el rendimiento, he utilizado un balanceo de carga de aplicaciones que distribuye tráfico entre las instancias de WordPress. Además, he implementado el escalado automático, lo que nos permite ajustar automáticamente la capacidad de la instancia según la carga de trabajo.</p>

<p>En resumen, este proyecto nos permite crear una infraestructura automatizada en AWS, proporcionando una sólida y base escalable para alojar nuestras instancias de WordPress. Ofrece flexibilidad, alta disponibilidad y la capacidad de adaptarse a los cambios en la demanda, asegurando una experiencia de usuario óptima.</p>

<div align="center">
   <img src="https://github.com/Kells02/Terraform-AWS/assets/101474487/d6ad5066-f8c1-4147-b044-1d7149275104">
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
