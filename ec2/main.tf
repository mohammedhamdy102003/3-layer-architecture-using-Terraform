resource "aws_instance" "bastion" {
    ami="ami-0c02fb55956c7d316"
    instance_type = t2.micro
    subnet_id=var.public_subnet
    vpc_security_group_ids=[var.sg_bastion]
    key_name = "my_key_pair"
    tags = {
        Name = "bastion_host"
    }
}
resource "aws_instance" "nginx" {
    ami="ami-0c02fb55956c7d316"
    instance_type = t2.micro
    subnet_id=var.private_subnet
    vpc_security_group_ids=[var.sg_app_id]
    key_name = "my_key_pair"
    tags = {
        Name = "nginx_server"
    }
    user_data = <<-EOF
                #!/bin/bash
                sudo apt update -y
                sudo apt install nginx -y
                sudo systemctl start nginx
                sudo systemctl enable nginx
                EOF
  
}