resource "aws_vpc_peering_connection" "peering" {
    count = var.is_peering_required ? 1 : 0
    vpc_id        = aws_vpc.main.id  #Requester
    peer_vpc_id   = data.aws_vpc.default.id  #Acceptor
    auto_accept   = true  

  tags = merge (
    var.common_tags,
    var.vpc_peering_tags,
    {
        Name = "${local.resource_name}-default"  #expense-dev-default 
                                        #expense-dev is merging with default VPC
    }
  )
}

#After peering VPCs, adding routes - public

resource "aws_route" "public_peering" {
    count = var.is_peering_required ? 1 : 0
    route_table_id = aws_route_table.public.id
    destination_cidr_block = data.aws_vpc.default.cidr_block
    vpc_peering_connection_id = aws_vpc_peering_connection.peering[count.index].id
}

#After peering VPCs, adding routes - private 
resource "aws_route" "private_peering" {
    count = var.is_peering_required ? 1 : 0
    route_table_id = aws_route_table.private.id
    destination_cidr_block = data.aws_vpc.default.cidr_block
    vpc_peering_connection_id = aws_vpc_peering_connection.peering[count.index].id
}

#After peering VPCs, adding routes - database

resource "aws_route" "database_peering" {
    count = var.is_peering_required ? 1 : 0
    route_table_id = aws_route_table.database.id
    destination_cidr_block = data.aws_vpc.default.cidr_block
    vpc_peering_connection_id = aws_vpc_peering_connection.peering[count.index].id
}

#default VPC side routing

resource "aws_route" "default_peering" {
    count = var.is_peering_required ? 1 : 0
    route_table_id = data.aws_route_table.main.route_table_id
    destination_cidr_block = var.vpc_cidr
    vpc_peering_connection_id = aws_vpc_peering_connection.peering[count.index].id
}