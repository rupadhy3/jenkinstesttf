provider "aws" {
region = "us-east-1"
}

variable "pubkey" {
   type = string
   default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCd/IZkaLQdSEHjoEMvvE7b65CV+FsJc9gFcublKSyzWgFM3aJIkCEo58v7KCL1c2GyU3k4IRppl4ZGJy28oOoQQol4ai9r39XUjGI1BGQclB9SHMWa9g33L9v2vKGBd4h/8fAFbw2pJgODXuo5pHmiAwVJtomKgc4C2TVdKsaSaysosztRUd/Y5bsSnvYE1gmDdSL4/vSj98r+5oeJ8btPQQdlwFdgf7Zy561hY2Ho7gDdioCIl1ZJeGgijTcQrp/BVK+tGT8HPK6PKMNG7dvGxBkQmPD5JvSn8UiDzxRDUOHp0Zq8RSrWuzs/6oMQjc1oCNFlZ/h9y/EbYm4pOnsd root@ip-172-31-30-163.ec2.internal"
}

resource "aws_instance" "myserver" {
  ami = "ami-02e136e904f3da870"
  instance_type = "t2.micro"
  key_name = "aws_key_pair.mykeypair.key_name"

  tags = {
    Name = "rak-29oct"
    env = "prod"
  }
  provisioner "local-exec" {
    command = "echo The servers IP address is ${self.public_ip} && echo ${self.public_ip} > /root/inv"
  }
  depends_on = [
    aws_key_pair.mykeypair,
  ]
}

resource "aws_key_pair" "mykeypair" {
  key_name   = "rukey-29oct"
  public_key = var.pubkey
}
