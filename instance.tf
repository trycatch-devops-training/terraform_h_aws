resource "aws_key_pair" "key-pair" {
  key_name   = "instancekey"
  public_key = file("genkey1.pub")
}

resource "aws_instance" "tst-web" {
  instance_type          = "t3.micro"
  ami                    = var.ami[var.region]
  subnet_id              = aws_subnet.private-subnet-1.id
  vpc_security_group_ids = [aws_security_group.tst-sg.id]
  availability_zone      = var.availability-zone-1a
}

resource "aws_ebs_volume" "tst-vol-2" {
  availability_zone = var.availability-zone-1a
  size              = 4

  tags = {
    name = "secondary volume"
  }
}

resource "aws_volume_attachment" "ebs-attach" {
  device_name = "/dev/sdb"
  volume_id   = aws_ebs_volume.tst-vol-2.id
  instance_id = aws_instance.tst-web.id
}

output "private_ip" {
  value = aws_instance.tst-web.private_ip
}

output "public_ip" {
  value = aws_instance.tst-web.public_ip
}