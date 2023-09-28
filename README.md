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

### Working with Environment Variables (env var)
#### `env` command

Environment variables are able to be listed our by using the `env` command. 

Specific env vars can be filtered by using the `grep` command (ex: `env | grep AWS`)

#### Setting and Unsetting Env Vars
In the terminal, env vars can be set using: `export HELLO ='world`

Env vars can be unset by using: `unset HELLO`

An env var can be set temporarily by running the command:
```sh
HELLO = 'world' ./bin/print_message
```

Within a bash script, a env var be writting without writing export:
```sh
#!/usr/bin/env bash

HELLO = 'world'
echo $HELLO
```

#### Printing Env Vars

We can print an env var by using echo: `echo $HELLO`

#### Scoping of Env Vars

When opening new bash terminals in VSCode it will not be aware of any env vars that were set in another windows. 

In order to have env vars persist across all future bash terminals that are open, new env vars must be set in bash profile ex: `bash_profile`

#### Persisting Env Vars in Gitpod

Env Vars can persist in Gitpod by storing them in Gitpod Secrets Storage

```
gp env HELLO = 'world'
```

All future workspaaces launched will set the env vars for all bash terminals opened in those workspaces. 

Env vars can also be set in the `.gitpod.yml` but this can only contain non-sensitive env vars. 