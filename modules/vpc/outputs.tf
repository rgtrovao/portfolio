output "vpc_id" {
  description = "ID da VPC."
  value       = aws_vpc.this.id
}

output "vpc_name" {
  description = "Name tag da VPC."
  value       = aws_vpc.this.tags["Name"]
}

output "igw_id" {
  description = "ID do Internet Gateway."
  value       = aws_internet_gateway.this.id
}

output "igw_name" {
  description = "Name tag do Internet Gateway."
  value       = aws_internet_gateway.this.tags["Name"]
}

output "public_subnet_ids" {
  description = "IDs das subnets públicas."
  value       = [for s in aws_subnet.public : s.id]
}

output "public_subnet_names" {
  description = "Name tags das subnets públicas."
  value       = [for s in aws_subnet.public : s.tags["Name"]]
}

output "private_subnet_ids" {
  description = "IDs das subnets privadas."
  value       = [for s in aws_subnet.private : s.id]
}

output "private_subnet_names" {
  description = "Name tags das subnets privadas."
  value       = [for s in aws_subnet.private : s.tags["Name"]]
}

output "db_subnet_ids" {
  description = "IDs das subnets de banco (isoladas)."
  value       = [for s in aws_subnet.db : s.id]
}

output "db_subnet_names" {
  description = "Name tags das subnets de banco."
  value       = [for s in aws_subnet.db : s.tags["Name"]]
}

output "nat_gw_id" {
  description = "ID do NAT Gateway."
  value       = aws_nat_gateway.this.id
}

output "nat_gw_name" {
  description = "Name tag do NAT Gateway."
  value       = aws_nat_gateway.this.tags["Name"]
}

output "nat_eip_allocation_id" {
  description = "Allocation ID do Elastic IP do NAT."
  value       = aws_eip.nat.id
}

output "nat_eip_name" {
  description = "Name tag do Elastic IP do NAT."
  value       = aws_eip.nat.tags["Name"]
}

output "public_route_table_id" {
  description = "ID da route table pública."
  value       = aws_route_table.public.id
}

output "public_route_table_name" {
  description = "Name tag da route table pública."
  value       = aws_route_table.public.tags["Name"]
}

output "private_route_table_id" {
  description = "ID da route table privada."
  value       = aws_route_table.private.id
}

output "private_route_table_name" {
  description = "Name tag da route table privada."
  value       = aws_route_table.private.tags["Name"]
}

output "db_route_table_id" {
  description = "ID da route table de banco."
  value       = aws_route_table.db.id
}

output "db_route_table_name" {
  description = "Name tag da route table de banco."
  value       = aws_route_table.db.tags["Name"]
}

