provider "aws" {
  region     = "ap-south-1"
}
module "ec2_instance" {
  source = "../modules/ec2_instance/"
  name                        = "server"
  availability_zone           = "ap-south-1a"
  instance_type               = "t2.micro"
  key_name                    = "newaccount"
  user_data                   = "./provisioning/userdata.txt"
  amis                        = {"ap-south-1" = "ami-0ce933e2ae91880d3" 
                                    "eu-west-1" = "ami-def456"}                              
}
resource "null_resource" "sekolahlinux" {
  triggers {
    cluster_instance_ids = "${join("\n", module.ec2_instance.id)}"
  }

  provisioner "local-exec" {
    working_dir = "./provisioning"
    command = "echo '[server:vars] \nansible_ssh_private_key_file = /root/.ssh/id_rsa \n\n[server:children] \nserver-app \n\n[server-app]' > ansible_hosts"
  }

  provisioner "local-exec" {
    working_dir = "./provisioning"
    command = "echo '${join("\n", formatlist("%s ansible_host=%s ansible_port=22 ansible_user=ec2-user", module.ec2_instance.name, module.ec2_instance.private_ip))}' >> ansible_hosts"
  }

}
