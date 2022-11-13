module "ec2" {
  source             = "./ec2"
  basename           = "cluster-one"
  environment        = "demo"
  ami                = data.aws_ami.ubuntu-linux.id
  vpc_id             = aws_vpc.vpc.id
  security_group_ids = [aws_security_group.main_sg.id]
  subnet_id          = aws_subnet.private-subnet-a.id
  ssh_key_name       = aws_key_pair.key_pair.key_name
  instance_type      = "t3.micro"
}

module "ec2_public" {
  source                      = "./ec2"
  basename                    = "cluster-two"
  environment                 = "demo"
  ami                         = data.aws_ami.ubuntu-linux.id
  vpc_id                      = aws_vpc.vpc.id
  security_group_ids          = [aws_security_group.main_sg.id]
  subnet_id                   = aws_subnet.subnet-a.id
  ssh_key_name                = aws_key_pair.key_pair.key_name
  instance_type               = "t3.micro"
  associate_public_ip_address = true
  instance_count              = (["1", "2"])
}