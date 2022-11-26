variable "AWS_REGION" {
  type    = string
  default = "eu-central-1"
}

variable "AWS_ACCOUNT_ID" {
  type = string
}

variable "ATLAS_ORG_ID" {
  type        = string
  description = "the ID of your MongoDB Atlas organization"
}

variable "ATLAS_PUB_KEY" {
  type        = string
  description = "public key for MongoDB Atlas"
}

variable "ATLAS_PRIV_KEY" {
  type        = string
  description = "private key for MongoDB Atlas"
}

variable "ATLAS_REGION" {
  type    = string
  default = "EU_CENTRAL_1"
}

variable "ATLAS_CIDR_BLOCK" {
  type = string
  default = "192.168.248.0/21"
}

variable "ATLAS_PROJECT_NAME" {
  type    = string
  default = "demo-pr"
}

variable "ATLAS_DB_NAME" {
  type    = string
  default = "demo"
}

variable "ATLAS_DB_USER" {
  type    = string
  default = "admin"
}

variable "ATLAS_DB_PASS" {
  type    = string
  default = "admin"
}
