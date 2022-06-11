terraform {
  required_version = ">= 1.1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.28.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.0.0"
    }

    template =  {
      source  = "hashicorp/template"
      #version = "~> 1.0"
   }
   
    null = {
      source  = "hashicorp/null"
      #version = "~> 1.0"
   }
  }

}
