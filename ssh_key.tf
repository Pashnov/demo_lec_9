resource "tls_private_key" "ec2_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "aws_key_pair" "key_pair" {
  key_name   = "demo_key"
  public_key = tls_private_key.ec2_key.public_key_openssh

  provisioner "local-exec" {
    command = "echo '${tls_private_key.ec2_key.private_key_pem}' > ./key/myKey.pem"
  }

  provisioner "local-exec" {
    command = "chmod 400 ./key/myKey.pem"
  }

  lifecycle {
    ignore_changes = [tags]
  }
}
