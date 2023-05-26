# --Definimos el proveedor (AWS)--

provider "aws" {
  region     = var.region // Region (us-east-1)
  access_key = var.access_key // Clave de acceso pública a la cuenta de AWS
  secret_key = var.secret_key // Clave de acceso privada a la cuenta de AWS
}