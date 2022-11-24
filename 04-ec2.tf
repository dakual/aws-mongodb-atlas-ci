resource "aws_instance" "main" {
  ami                         = local.ami
  instance_type               = local.instance_type
  key_name                    = local.key_name
  vpc_security_group_ids      = [ aws_security_group.main.id ] 
  subnet_id                   = aws_subnet.public.0.id
  associate_public_ip_address = true

  connection {
    type        = "ssh"
    user        = "admin"
    private_key = file(local.key_path)
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install gnupg -y",
      "sudo wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc | sudo apt-key add -",
      "sudo echo \"deb http://repo.mongodb.org/apt/debian buster/mongodb-org/6.0 main\" | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list",
      "sudo apt-get update",
      "sudo apt-get install -y mongodb-org"
    ]
  }
}

output "ec2_public_ip" {
  value = aws_instance.main.public_ip
}
