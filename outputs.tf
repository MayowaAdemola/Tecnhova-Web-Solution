output "ec2_public_ip" {
  description = "Public IP address of the EC2 web server"
  value       = aws_instance.web.public_ip
}

output "ec2_public_dns" {
  description = "Public DNS name of the EC2 web server"
  value       = aws_instance.web.public_dns
}

output "rds_endpoint" {
  description = "RDS database endpoint"
  value       = aws_db_instance.main.endpoint
}

output "rds_host" {
  description = "RDS database hostname"
  value       = aws_db_instance.main.address
}

output "s3_bucket_name" {
  description = "Name of the S3 assets bucket"
  value       = aws_s3_bucket.assets.bucket
}

output "aws_region" {
  description = "AWS region"
  value       = var.aws_region
}

output "ssh_command" {
  description = "Command to SSH into the EC2 instance"
  value       = "ssh -i ../ansible/technova-key.pem ubuntu@${aws_instance.web.public_ip}"
}
