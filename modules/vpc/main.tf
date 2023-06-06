resource "aws_vpc" "main" {
    instance_tenancy = "default"
    cidr_block       = var.cidr
    
    tags = var.tags
}

resource "aws_security_group" "main-sg" {
   name   = "${var.name}-SG"
   vpc_id = aws_vpc.main.id                                # alternative way: vpc_id = module.vpc.name_of_output_block_to_print_vpc_id (for this case my_vpc_id) 

   ingress {
      description = "SSH"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
   }

   ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    ="tcp"
    cidr_blocks  = ["0.0.0.0/0"]
   }

   ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    ="tcp"
    cidr_blocks  = ["0.0.0.0/0"]
   }

   egress {
    from_port   = 0
    to_port     = 0
    protocol    ="-1"
    cidr_blocks = ["0.0.0.0/0"]
   }

   tags = {
    terraform = "true"
    Name      = "${var.name}-SG"
   }
}

resource "aws_subnet" "public" {
    count                   = "${length(var.public_subnet)}"
    vpc_id                  = aws_vpc.main.id
    cidr_block              = "${var.public_subnet[count.index]}"
    availability_zone       = var.az
    map_public_ip_on_launch = true

    tags = {
        Name = "${var.name}-public-subnet"
    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id

    tags = {
        Name = "${var.name}-IGW"
    }
}

resource "aws_route_table" "public_route"{
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
        Name = "${var.name}-public-route"
    }
}

resource "aws_route_table_association" "public" {
    count               = length(var.public_subnet)
    subnet_id           = aws_subnet.public[count.index].id
    route_table_id      = aws_route_table.public_route.id
}

resource "aws_subnet" "private" {
    vpc_id                  = aws_vpc.main.id
    cidr_block              = var.private_subnet
    availability_zone       = var.az
    map_public_ip_on_launch = false

    tags = {
        Name = "${var.name}-private-subnet"
    }
}

resource "aws_eip" "gamex" {
    vpc     = true

    tags    = {
       Name       = "${var.name}-eip"
    }
}

resource "aws_nat_gateway" "nat_gw" {
    subnet_id               = aws_subnet.public[0].id
    allocation_id           = aws_eip.gamex.id

    tags                    = {
                      Name  = "${var.name}-NAT"
    }

    depends_on = [aws_internet_gateway.igw]
}

resource "aws_route_table" "private_route" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.nat_gw.id
    }

    tags = {
        Name = "${var.name}-private-route"
    }
}

resource "aws_route_table_association" "private" {
    subnet_id           = aws_subnet.private.id
    route_table_id      = aws_route_table.private_route.id
}