# resource "aws_vpc" "main" {
#   cidr_block = "10.0.0.0/16"
#   tags = {
#     Name = "Santhra_vpc"
#   }
# }


data "aws_vpc" "fetchmyvpc"{
    id=var.vpc_id
}

data "aws_availability_zones" "allzones"{

}

output "allzones"{
    value=data.aws_availability_zones.allzones
}
resource "aws_subnet" "main" {
  count=length(data.aws_availability_zones.allzones.names)
  vpc_id     = data.aws_vpc.fetchmyvpc.id
  cidr_block = "10.0.${count.index+4}.0/24"
  availability_zone=data.aws_availability_zones.allzones.names[count.index]
  tags = {
    Name = "${var.subnet_prefix}_10.0.${count.index+1}.0/24"
  }
}