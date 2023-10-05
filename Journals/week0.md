# Terraform Beginner Bootcamp Week 0
Table of Contents
- [Semantic Versioning](#semantic-versioning)
- [Install Terraform CLI](#install-terraform-cli)
  * [Considerations for Linux Distribution](#considerations-for-linux-distribution)
  * [Refactoring into Bash Scripts](#refactoring-into-bash-scripts)
    + [Shebang Considerations](#shebang-considerations)
    + [Linux Permissions Considerations](#linux-permissions-considerations)
  * [Gitpod Lifecycle (Before, Init Command)](#github-lifecycle--before--init-command-)
  * [Working Env Vars](#working-env-vars)
    + [env command](#env-command)
    + [Setting and Unsetting Env Vars](#setting-and-unsetting-env-vars)
    + [Printing Vars](#printing-vars)
    + [Scoping of Env Vars](#scoping-of-env-vars)
    + [Persisting Env Vars in Gitpod](#persisting-env-vars-in-gitpod)
  * [AWS CLI Installation](#aws-cli-installation)
- [Terraform Basics](#terraform-basics)
  * [Terraform Registry](#terraform-registry)
  * [Terraform Console](#terraform-console)
    + [Terraform init](#terraform-init)
    + [Terraform Plan](#terraform-plan)
    + [Terraform Apply](#terraform-apply)
    + [Terraform Destroy](#terraform-destroy)
    + [Terraform Lock Files](#terraform-lock-files)
    + [Terraform State Files](#terraform-state-files)
    + [Terraform Directory](#terraform-directory)
- [Issues with Terraform Cloud Login and Gitpod Workspace](#issues-with-terraform-cloud-login-and-gitpod-workspace)

## Semantic Versioning
This project will utilize Semantic Versioning [semver.org](https://semver.org/) for its tagging in the following format:

**MAJOR.MINOR.PATCH** (`1.0.1`)

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes
Additional labels for pre-release and build metadata are available as extensions to the MAJOR.MINOR.PATCH format.

## Install Terraform CLI

The Terraform CLI installation instuructions have changed due to gpg keyring changes, therefore the latest CLI installation instructions needed to be referenced and the scripting changed. 
[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Considerations for Linux Distribution
This project is built using Ubuntu, please consider checking your Linux distribution and change according to distribution needs. 
[How to Check OS Version in Linux](https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/c)

Example:
```
$ cat /etc/os-release

PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```

### Refactoring into Bash Scripts

While fixing the Terraform CLI gpg deprecation issues, it was noticed that the bash scripts were a considerable amount more code. 

This bash script is located here: [./bin/install_terraform_cli](./bin/install_terraform_cli)

It was then decided to create a bash script to install the Terraform CLI for the following reasons:

- Keeping the Gitpod Task File tidy([.gitpod.yml](.gitpod.yml)).
- Terraform CLI Installation easier to debug and execute manually.
- Better portability for other projects requiring Terraform CLI installation. 

#### Shebang Considerations
A Shebang tells the bash script what program will interpret the script. ex `#!/bin/bash` 

#### Linux Permissions Considerations
In order to make bash scripts executable, Linux permissions for the file need to be executable at the user mode. 

```sh
chmod u+x ./bin/install_terraform_cli
```
Alternatively, it can be changed by:
```sh
chmod 744 ./bin/install_terraform_cli
```

## Gitpod Lifecycle (Before, Init Command)
Please be aware of using init, as it will not rerun if restarting an existing workspace. 
[https://www.gitpod.io/docs/configure/workspaces/tasks](https://www.gitpod.io/docs/configure/workspaces/tasks)

## Working Env Vars

### `env` command

Enviroment Variables (Env Vars) can be listed by using the `env` command

Specific env vars can be filtered by using grep: `env | grep AWS_`

### Setting and Unsetting Env Vars

In the terminal env vars can be set with `export HELLO='world`

In the terrminal env vars be unset using `unset HELLO`

An env var can be set temporarily by running a command:

```sh
HELLO='world' ./bin/print_message
```
Within a bash script an env var can set without writing export:

```sh
#!/usr/bin/env bash

HELLO='world'

echo $HELLO
```

### Printing Vars

An env var can be printed using echo: `echo $HELLO`

### Scoping of Env Vars

When opening a new bash terminal in VSCode, it will not be aware of env vars that were set in another window. 
I order for env vars to persist across all future bash terminals that are open, env vars need to be set in the bash profile. (`.bash_profile`)

### Persisting Env Vars in Gitpod

Env vars can persist into Gitpod by storing them in Gitpod Secrets Storage.

```
gp env HELLO='world'
```

All future workspaces launched will set the env vars for all bash terminals opened in those workspaces.

Env vars can also be set in the `.gitpod.yml` but this can only contain non-senstive env vars.

## AWS CLI Installation

The AWS CLI is installed for the project using the bash script [`./bin/install_aws_cli`](./bin/install_aws_cli)


[Getting Started Install (AWS CLI)](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
[AWS CLI Env Vars](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

The following AWS CLI command can be used to check if AWS credentials are configured correctly:
```sh
aws sts get-caller-identity
```

If successful, a JSON payload will return results similar to this:

```json
{
    "UserId": "AIEAVUO15ZPVHJ5WIJ5KR",
    "Account": "123456789012",
    "Arn": "arn:aws:iam::123456789012:user/terraform-beginner-bootcamp"
}
```
## Terraform Basics
### Terraform Registry
Terrform sources its providers and modules from the Terraform registry, which is located at [registry.terraform.io](https://registry.terraform.io/)

- **Providers** is a way to directly interact with an API to make it powered by Terraform.
[Random Terraform Provider](https://registry.terraform.io/providers/hashicorp/random/latest)

- **Modules** are a collection of Terraform files that provide a template to utilize commonly used actions. They make Terraform code modular, portable, and sharable. 

### Terraform Console
It is possible to list all of the Terraform commands by simply typing `terraform`.

#### Terraform init
At the start of a new Terraform project, running `terraform init` will download binaries for the Terraform providers used in this project. 

#### Terraform Plan
Terraform plan generates a changeset about the state of the infrastructure and what would be changed. 
The changeset (or plan) can be output to an apply, but it can often be ignored. 

#### Terraform Apply
Terraform apply will run a plan and pass the changeset to be executed by Terraform. It should prompt "yes" or "no," to automatically approve an apply use the `auto-approve` flag.

#### Terraform Destroy
`terraform destroy`
This command destroys resources. 
`terraform apply --auto-approve` can also be used to skip the approval prompt. 

#### Terraform Lock Files
`.terraform.lock.hcl` contains the locked versioning for the providers or modules that should be used with this project. 

The Terraform Lock file *should* be committed to the Version Control System (VCS) ex: GitHub. 

#### Terraform State Files 
`.terraform.tfstate` contains information about the state of the infrastructure. This file *should not* be committed to the VCS. 
This file can contain sensitive data, and losing this file means losing information about the state of the infrastructure. 

`.terraform.tfstate.backup` is the previous state file. 

#### Terraform Directory
`.terraform` directory contains binaries of terraform providers. 

## Issues with Terraform Cloud Login and Gitpod Workspace
When attempting to run `terraform login` it launches a wysiwyg view to generate a token. It does not work as expected in Gitpod VSCode in the browser.

The workaround is to manually generate a token Terraform Cloud:
```
https://app.terraform.io/app/settings/tokens?source=terraform-login``` 

Then create the file manually here:
```sh
touch /home/gitpod/.terraform.d/credentials.tfrc.json
open /home/gitpod/.terraform.d/credentials.tfrc.json```

Provide the following code (replacing with your generated token in the file):
```json
{
    "credentials": {
     "app.terraform.io": {
        "token" : "YOUR-TERRAFORM-TOKEN"
        }
    }
}
```
The process has been automated using a workaround with the following bash script [bin/generate_tfrc_creds](/bin/generate_tfrc_creds)