output "bucket_name" {
  value = module.home_bossa-nova_hosting.bucket_name
}

output "website_endpoint" {
  description = "S3 name for static website hosting"
  value = module.home_bossa-nova_hosting.website_endpoint
}

output "domain_name" {
  value = module.home_bossa-nova_hosting.domain_name
  
}