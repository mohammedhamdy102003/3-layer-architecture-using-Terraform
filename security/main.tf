resource "aws_security_group" "bastion_sg" {
    name ="bastion_sg"
    description = "Security group for bastion host"
    vpc_id = aws_vpc.main.vpc_id
    ingress = {
        from_port =22
        to_port =22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    } 
    egress = {
        from_port =0
        to_port =0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
}
    tags = {
        Name = "bastion_sg"
    }
}
resource "aws_security_group" "app_sg" {
    name="app_sg"
    description = "Security group for application servers"
    vpc_id = aws_vpc.main.vpc_id
    ingress = {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        security_groups = [aws_security_group.bastion_sg.id]
}
egress={
    from_port =0
    to_port =0 
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
}
    tags = {
        Name = "app_sg"
    }
}
output "sg_bastion_id" { value = aws_security_group.bastion_sg.id }
output "sg_app_id" { value = aws_security_group.app_sg.id }
