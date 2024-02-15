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
  cloud {
    organization = "dwashington100292"

    workspaces {
      name = "terra-house-1"
    }
  } 


}

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid= var.teacherseat_user_uuid
  token=var.terratowns_access_token
  
}

module "home_bossa-nova_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.bossa-nova.public_path
  content_version = var.bossa-nova.content_version
}

resource "terratowns_home" "home" {
  name = "Bossa Nova for the World!"
  description = <<DESCRIPTION
Bossa nova, a music style created in Brazil, quite literally means 
"new wave." It is known for its smooth, elegant melodies that is a 
blend of samba and jazz. It originated in Rio de Janeiro's Copacabana neighborhood. 
DESCRIPTION
  domain_name = module.home_bossa-nova_hosting.domain_name
  town = "melomaniac-mansion"
  content_version = 2
}

module "home_reality-tv_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.reality-tv.public_path
  content_version = var.reality-tv.content_version
}

resource "terratowns_home" "home_reality" {
  name = "Iconic Moments in Reality TV"
  description = <<DESCRIPTION
Some of us despise reality tv, while some of us revel in its chaos!
Although some may try, it's a Herculean effort to try and escape the effects of pop culture.
DESCRIPTION

 domain_name = module.home_reality-tv_hosting.domain_name
 town = "video-valley"
 content_version = 2
}