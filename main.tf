provider "aws" {
    access_key = "${var.AWS_ACCESS_KEY}"
    secret_key = "${var.AWS_SECRET_KEY}"
    region = "${var.AWS_REGION}"
}

provider "atlas" {
  token = "${var.ATLAS_TOKEN}"
}

resource "atlas_artifact" "packer2" {
  name = "kyawthetsein/packer2"
  type = "amazon.ami"
  version = "latest"
}

resource "aws_instance" "packer2" {
  ami = "${atlas_artifact.packer2.metadata_full.region-us-west-2}"
  key_name = "vagrant"
  instance_type = "t2.micro"
  
/*  connection {
      user = "ubuntu"
      #password = "${var.USER_PASSWORD}"
      type = "ssh"
      private_key = "${var.AWS_SSH_KEY}"

    }
  provisioner "remote-exec" {
      
        inline = [
          "sudo apt-get -y update",
          "sudo apt-get -y install nginx",
          "sudo service nginx start"
      ]
    } */


  tags {
    Name = "packer2"
  }
}
