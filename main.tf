resource "atlas_artifact" "packer" {
  name = "kyawthetsein/packer"
  type = "amazon.ami"
  version = "1"
}

resource "aws_instance" "packer2" {
  connection {
      user = "ubuntu"

      key = "${var.AWS_SSH_KEY}"

    }
  ami = "${atlas_artifact.packer.metadata_full.region-us-west-2}"
  key_name = "vagrant"
  instance_type = "t2.micro"
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
