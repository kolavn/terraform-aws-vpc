output "vpc_id"{
    value = aws_vpc.main.id
}

output "az_info" {
    value = data.aws_availability_zones.available
}

#to know VPC info
output "default_vpc_info" {
    value = data.aws_vpc.default
}

output "main_route_table_info" {
    value = data.aws_route_table.main
}

output "public_subnet_ids" {
    value = aws_subnet.public[*].id
}

output "private_subnet_ids" {
    value = aws_subnet.private[*].id
}

output "database_subnet_ids" {
    value = aws_subnet.database[*].id
}