resource "aws_instance" "mongodb_server" {
   ami                        = var.ami_id
   instance_type              = var.instance_type
   subnet_id                  = var.private_subnet_id
   vpc_security_group_ids     = [var.security_group_id]
   key_name                   = var.key_name
   monitoring                 = true
   iam_instance_profile       = var.instance_profile
      
   root_block_device { 
      volume_size = 8
      volume_type = "gp3"
      encrypted = true
   }

   tags = {
      Name = "gamex-mongodb-server"
   }
}

resource "aws_instance" "express_server" {
   ami                        = var.ami_id
   instance_type              = var.instance_type
   subnet_id                  = element(var.public_subnet_id, 0)
   vpc_security_group_ids     = [var.security_group_id]
   key_name                   = var.key_name
   monitoring                 = true
      
   root_block_device { 
      volume_size = 8
      volume_type = "gp3"
      encrypted = true
   }

   tags = {
      Name = "gamex-express-server"
   }
}

resource "aws_instance" "admin_server" {
   ami                        = var.ami_id
   instance_type              = var.instance_type
   subnet_id                  = element(var.public_subnet_id, 1)
   vpc_security_group_ids     = [var.security_group_id]
   key_name                   = var.key_name
   
   root_block_device { 
      volume_size = 8
      volume_type = "gp3"
      encrypted = true
   }

   tags = {
      Name = "gamex-admin-server"
   }
}