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

### Path Variable
In Terraform, there is a special variable called `path` that allows for us to reference local paths:
- path.module = path for the current module
- path.root = path for the root module
[Special Path Variable ](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object)