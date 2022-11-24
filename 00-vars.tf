variable "aws_region" {
  type = string
  default = "eu-central-1"
}

variable "aws_account_id" {
  type = string
}

variable "atlas_org_id" {
  type        = string
  description = "the ID of your MongoDB Atlas organization"
}

variable "atlas_pub_key" {
  type        = string
  description = "public key for MongoDB Atlas"
}

variable "atlas_priv_key" {
  type        = string
  description = "private key for MongoDB Atlas"
}

variable "atlas_region" {
  type    = string
  default = "EU_CENTRAL_1"
}

variable "atlas_cidr_block" {
  type = string
  default = "192.168.248.0/21"
}

variable "atlas_project_name" {
  type    = string
  default = "demo-pr"
}

variable "atlas_db_name" {
  type    = string
  default = "demo"
}

variable "atlas_db_user" {
  type    = string
  default = "admin"
}

variable "atlas_db_pass" {
  type    = string
  default = "admin"
}
