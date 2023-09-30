# Terraform Beginner Bootcamp 2023

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

### GitHub Lifecycle (Before, Init Command)
Please be aware of using init, as it will not rerun if restarting an existing workspace. 
[https://www.gitpod.io/docs/configure/workspaces/tasks](https://www.gitpod.io/docs/configure/workspaces/tasks)

### Working Env Vars

#### env command

Enviroment Variables (Env Vars) can be listed by using the `env` command

Specific env vars can be filtered by using grep: `env | grep AWS_`

#### Setting and Unsetting Env Vars

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

#### Printing Vars

An env var can be printed using echo: `echo $HELLO`

#### Scoping of Env Vars

When opening a new bash terminal in VSCode, it will not be aware of env vars that were set in another window. 
I order for env vars to persist across all future bash terminals that are open, env vars need to be set in the bash profile. (`.bash_profile`)

#### Persisting Env Vars in Gitpod

Env vars can persist into Gitpod by storing them in Gitpod Secrets Storage.

```
gp env HELLO='world'
```

All future workspaces launched will set the env vars for all bash terminals opened in those workspaces.

Env vars can also be set in the `.gitpod.yml` but this can only contain non-senstive env vars.

### AWS CLI Installation

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



