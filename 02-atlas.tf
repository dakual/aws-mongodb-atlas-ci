resource "mongodbatlas_project" "demo" {
  name   = var.atlas_project_name
  org_id = var.atlas_org_id
}

resource "mongodbatlas_cluster" "cluster" {
  project_id = mongodbatlas_project.demo.id
  name       = var.atlas_project_name

  provider_instance_size_name = "M0"
  provider_name               = "TENANT"
  backing_provider_name       = "AWS"
  provider_region_name        = var.atlas_region
}

resource "mongodbatlas_database_user" "user" {
  project_id         = mongodbatlas_project.demo.id
  auth_database_name = "admin"

  username = var.atlas_db_user
  password = var.atlas_db_pass

  roles {
    role_name     = "readWrite"
    database_name = var.atlas_db_name
  }
}

resource "mongodbatlas_network_container" "main" {
  project_id       = mongodbatlas_project.demo.id
  atlas_cidr_block = var.atlas_cidr_block
  provider_name    = "AWS"
  region_name      = var.atlas_region
}

resource "mongodbatlas_network_peering" "main" {
  accepter_region_name   = var.aws_region
  project_id             = mongodbatlas_project.demo.id
  container_id           = mongodbatlas_network_container.main.container_id
  provider_name          = "AWS"
  route_table_cidr_block = local.cidr
  vpc_id                 = aws_vpc.main.id
  aws_account_id         = var.aws_account_id
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
#     "://${var.atlas_db_user}:${mongodbatlas_database_user.user.password}@"
#   )
#   sensitive = true
# }