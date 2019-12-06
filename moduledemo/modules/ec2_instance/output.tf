output "SecurityGroupIDs" {
  value = aws_instance.myec2server[*].vpc_security_group_ids
}
output "instance_id" {
  value = aws_instance.myec2server[*].id
}
output "ip" {
 value = aws_instance.myec2server[*].private_ip
}
