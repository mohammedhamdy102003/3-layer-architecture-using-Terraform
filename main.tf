module "vpc" {
    source = "./vpc"
}
module "security" {
  source = "./security"
}
module "ec2" {
    source = "./ec2"
     vpc_id= module.vpc.vpc_id
     public_subnet=module.vpc.public_subnets[0]
     private_subnet=module.vpc.private_subnets[0]
     sg_bastion=module.security.sg_bastion_id
     sg_app_id= module.security.sg_app_id
}
module "loadbalancer" {
    source = "./loadbalancer"
    public_subnets=module.vpc.public_subnets
    private_subnets=module.vpc.private_subnets
    sg_lb_id=module.security.sg_lb_id
}
module "s3" {
    source = "./s3"
    
  
}