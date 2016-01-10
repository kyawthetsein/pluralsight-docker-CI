resource "aws_instance" "packer2" {
  ami = "${atlas_artifact.packer2.metadata_full.region-us-west-2}"
  key_name = "vagrant"
  instance_type = "t2.micro"
  count = 1
  
  connection {
      user = "ubuntu"
      private_key = "${var.AWS_SSH_KEY}"
      agent = false

    }
  
  provisioner "remote-exec" {
        inline = [
          "sudo apt-get -y update",
          "sudo apt-get -y install nginx",
          "sudo service nginx start"
        ]
    }


  tags {
    Name = "packer2"
  }
}
