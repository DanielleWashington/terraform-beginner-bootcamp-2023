terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
  #backend "remote" {
  #  hostname = "app.terraform.io"
  #  organization = "dwashington100292"

  #  workspaces {
  #    name = "terra-house-1"
  #  }
  #}
  # cloud {
  #   organization = "dwashington100292"

  #   workspaces {
  #     name = "terra-house-1"
  #   }
  # } 


}

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid= var.teacherseat_user_uuid
  token=var.terratowns_access_token
  
}

resource "terratowns_home" "home" {
  name = "Bossa Nova for the World!"
  description = <<DESCRIPTION
Bossa nova, a music style created in Brazil, quite literally means 
"new wave." It is known for its smooth, elegant melodies that is a 
blend of samba and jazz. It originated in Rio de Janeiro's Copacabana neighborhood. 
DESCRIPTION
 domain_name = module.terrahouse_aws.cloudfront_url
 town = "missingo"
 content_version = 1
}
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.teacherseat_user_uuid
  bucket_name = var.bucket_name
  index_html_filepath = var.index_html_filepath
  error_html_filepath = var.error_html_filepath
  content_version = var.content_version
  assets_path = var.assets_path

}