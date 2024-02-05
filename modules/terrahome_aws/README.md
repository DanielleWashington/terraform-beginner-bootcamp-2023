# Terrahome AWS

```tf
module "home_bossa-nova" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.bossa-nova_public_path
  content_version = var.content_version
}
```

The public directory expects the following:

- index.html
- error.html
- assets 

All the top level files in assets will be copied, but not any subdirectories.