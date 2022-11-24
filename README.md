## Creating MongoDb Atlas Cluster and VPC Peering with AWS

> terraform.tfvars
```sh
aws_account_id = "<aws-account-id>"
atlas_pub_key  = "<public-key>"
atlas_priv_key = "<private-key>"
atlas_org_id   = "<organization-id>"
```

Creating infrastructure
```sh
terraform init
terraform apply --auto-approve
```

Preparing Mongodb Client on the debian machine
```sh
# Install required package
apt-get install gnupg

# import the MongoDB public GPG Key
wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc | apt-key add -

# Create a /etc/apt/sources.list.d/mongodb-org-6.0.list file for MongoDB
echo "deb http://repo.mongodb.org/apt/debian buster/mongodb-org/6.0 main" | tee /etc/apt/sources.list.d/mongodb-org-6.0.list

# Reload local package database.
apt-get update

# Install the MongoDB packages.
apt-get install -y mongodb-org
```