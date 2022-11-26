## Creating MongoDb Atlas Cluster and VPC Peering with AWS

> terraform.tfvars
```sh
AWS_ACCOUNT_ID = "<aws-account-id>"
ATLAS_PUB_KEY  = "<public-key>"
ATLAS_PRIV_KEY = "<private-key>"
ATLAS_ORG_ID   = "<organization-id>"
```

GitLab Variables
```sh
TF_VAR_AWS_ACCOUNT_ID
TF_VAR_ATLAS_PUB_KEY
TF_VAR_ATLAS_PRIV_KEY
TF_VAR_ATLAS_ORG_ID
TF_TOKEN
AWS_SECRET_ACCESS_KEY
AWS_ACCESS_KEY_ID
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