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