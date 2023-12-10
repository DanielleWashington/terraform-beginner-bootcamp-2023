# Terraform Beginner Bootcamp Week 1

## Root Module Structure

The root module structure is as follows:

```
PROJECT_ROOT
│
├── main.tf                 # everything else.
├── variables.tf            # stores the structure of input variables
├── terraform.tfvars        # the data of variables we want to load into our terraform project
├── providers.tf            # defined required providers and their configuration
├── outputs.tf              # stores our outputs
└── README.md               # required for root modules
```
[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)

## Terraform and Input Variables

### Terraform Cloud Variables

Two types of variables are able to be set in Terraform Cloud:
- Enviroment Variables - those set in a bash terminal (AWS credentials)
- Terraform Variables - those normally set in a tfvars file

Terraform Cloud variables can be set to "sensitive" so they are not shown visibliy in the UI.

### Loading Terraform Input Variables

[Terraform Input Variables](https://developer.hashicorp.com/terraform/language/values/variables)

### var flag
The `-var` flag can be used to set an input variable or override a variable in the tfvars file (`terraform -var user_ud="my-user_id"`)

### var-file flag

The `var-file` flag passes input variables into `plan` and `apply` commands using a file that contains those values. The input variable values can be saved in a file with a `.tfvars` extension. 
For example, below inputs variables into the `apply` command into a "Secrets" and "Dev" file:
```sh
tf apply
-var-file 'secrets.tfvars'
-var-file 'dev.tfvars'
```


### terraform.tvfars

This is the default file to load in terraform variables in blunk

### auto.tfvars

The `.auto.tfvars` functionality allows for Terrafotm to automatically load variable definitions. 

### Order of Precedence
The order of precedence in Terraform determines the value of a variable. Should the same variable be assigned multiple values, then Terraform will use the value of highest precedence and override any other values. 
List (in order from highest to lowest priority):
1. Environment (`tf_var_variable_name`)
2. `terraform.tfvars` file
3. `terraform.tfvars.json` file
4. `.auto.tfvars` or `.auto.tfvars.json`
5. `-var` or `-var-file` options on the command line, in the order they are provided.
6. variable defaults

[Terraform Variables](https://www.env0.com/blog/terraform-variables)

## Dealing with Coniguration Drift
## What Happens if the State File is Lost?
If the state file is lost, the infrastructure will mostly likely have to be manually torn down. 
Terraform import can be used, but it will not work for all cloud resources. The Terraform providers documentation should be checked for which resources support `import`.
### Fix Missing Resources with Terraform Import

`terraform import aws_s3_bucket.example`
[Terraform Import](https://developer.hashicorp.com/terraform/cli/import)
[AWS S3 Bucket Import](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#import)

### Fix Manual Configuration 
If cloud resources are manually deleted or modified via "ClickOps," running `terraform plan` or `tf plan` will attempt to put infrastructure back into its expected state, fixing configuration drift.
### Fix using Terraform Refresh
```tf
terraform apply -refresh-only -auto-approve
```
## Terraform Modules

### Terraform Module Structure
It is recommended to place modules in a `modules` directory when locally developing modules, but they can be named whatever you like. 

### Passing Input Variables
Input variables can be passed to the module, the module has to declare Terraform variables in its own variables.tf 
```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
}
```
### Module Sources

Using the sour e, the module can be imported from various places like:
- locally
- GitHub
- Terraform Registry
```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
}
```

[Module Sources](https://developer.hashicorp.com/terraform/language/modules/sources)

## Considerations when sing ChatGPT to write Terraform
LLMs like ChatGPT may not be trained on the latest documentation or information about Terraform. 

It is likely to produce older, deprecated examples which often affect providers. 

## Working with Files in Terraform 

### Filemd5


[FIlemd5](https://developer.hashicorp.com/terraform/language/functions/filemd5)
### Fileexists Function
This is a built in function to check the existance of a file. 
```tf
  validation {
    condition     = fileexists(var.error_html_filepath)
  }
  ```
[Fileexists function documentation](https://developer.hashicorp.com/terraform/language/functions/fileexists)
### Path Variable
In Terraform, there is a special variable called `path` that allows for us to reference local paths:
- path.module = path for the current module
- path.root = path for the root module
[Special Path Variable ](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object)

```tf
resource "aws_s3_object" "index_html"{
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "index.html"
  source = var.index_html_filepath
  etag = filemd5(var.index_html_filepath)
}
```

## Terraform Locals
You can define local variables using Terraform Locals, it can be useful when transforming data into another format and having a referenced variable.

```tf
locals {
  service_name = "forum"
  owner        = "Community Team"
}
```
[Local Values](https://developer.hashicorp.com/terraform/language/values/locals)
## Terraform Data Sources
This allows you to use source data from cloud resources, it is useful when you want to reference resources without importing them. 

```tf
data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "caller_arn" {
  value = data.aws_caller_identity.current.arn
}

output "caller_user" {
  value = data.aws_caller_identity.current.user_id
}
```
[Data Sources](https://developer.hashicorp.com/terraform/language/data-sources)

## Working with JSON
Jsonencode can be used to create the JSON policy inline in HCL.
```tf
> jsonencode({"hello"="world"})
{"hello:world"}
```
[jsonencode](https://developer.hashicorp.com/terraform/language/functions/jsonencode)

### Changing the Lifecycle of Resources
[Meta Arguments Lifecycles](https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle)

## Terraform Data
Values like `local values` and `input variables` are not valid in `replaced_triggered_by` 

 You can use the behavior of `terraform_data` to plan an action each time input changes to indirectly use a plain value to trigger replacement.

[Terraform Data](https://developer.hashicorp.com/terraform/language/resources/terraform-data)

## Provisioners
Provisioners allow you to execute commands on compute instances (AWS CLI command), they are not recommended for use by HashiCorp because Configuration Management tools like Ansible are a better fit, but the functionality exists. 

[Provisioners](https://developer.hashicorp.com/terraform/language/resources/provisioners/syntax)
### Local-exec

Executes a command on the machine running the Terraform commands like `plan apply`

```tf
resource "aws_instance" "web" {
  # ...

  provisioner "local-exec" {
    command = "echo The server's IP address is ${self.private_ip}"
  }
}
```

[Local-exec](https://developer.hashicorp.com/terraform/language/resources/provisioners/local-exec)

### Remote Exec
Executes commands on a machine that you target, it requires credentials like ssh.

```tf
resource "aws_instance" "web" {
  # ...

  # Establishes connection to be used by all
  # generic remote provisioners (i.e. file/remote-exec)
  connection {
    type     = "ssh"
    user     = "root"
    password = var.root_password
    host     = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "puppet apply",
      "consul join ${aws_instance.web.private_ip}",
    ]
  }
}
```
[Remote-exec](https://developer.hashicorp.com/terraform/language/resources/provisioners/remote-exec)