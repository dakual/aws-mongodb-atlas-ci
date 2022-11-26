resource "mongodbatlas_project" "demo" {
  name   = var.ATLAS_PROJECT_NAME
  org_id = var.ATLAS_ORG_ID
}

resource "mongodbatlas_cluster" "cluster" {
  project_id = mongodbatlas_project.demo.id
  name       = var.ATLAS_PROJECT_NAME

  provider_instance_size_name = "M0"
  provider_name               = "TENANT"
  backing_provider_name       = "AWS"
  provider_region_name        = var.ATLAS_REGION
}

resource "mongodbatlas_database_user" "user" {
  project_id         = mongodbatlas_project.demo.id
  auth_database_name = "admin"

  username = var.ATLAS_DB_USER
  password = var.ATLAS_DB_PASS

  roles {
    role_name     = "readWrite"
    database_name = var.ATLAS_DB_NAME
  }
}

resource "mongodbatlas_network_container" "main" {
  project_id       = mongodbatlas_project.demo.id
  atlas_cidr_block = var.ATLAS_CIDR_BLOCK
  provider_name    = "AWS"
  region_name      = var.ATLAS_REGION
}

resource "mongodbatlas_network_peering" "main" {
  accepter_region_name   = var.AWS_REGION
  project_id             = mongodbatlas_project.demo.id
  container_id           = mongodbatlas_network_container.main.container_id
  provider_name          = "AWS"
  route_table_cidr_block = local.cidr
  vpc_id                 = aws_vpc.main.id
  aws_account_id         = var.AWS_ACCOUNT_ID
}

resource "mongodbatlas_project_ip_access_list" "all" {
  project_id = mongodbatlas_project.demo.id
  cidr_block = "0.0.0.0/0"
  comment    = "allow all" 
}

resource "mongodbatlas_project_ip_access_list" "aws" {
  project_id = mongodbatlas_project.demo.id
  cidr_block = local.cidr
  comment    = "cidr block for AWS"
}

output "atlas" {
  value = mongodbatlas_cluster.cluster.srv_address
}

# output "atlas" {
#   value = replace(
#     mongodbatlas_cluster.cluster.srv_address,
#     "://",
#     "://${var.ATLAS_DB_USER}:${mongodbatlas_database_user.user.password}@"
#   )
#   sensitive = true
# }