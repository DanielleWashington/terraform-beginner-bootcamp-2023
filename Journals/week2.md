# Terraform Beginner Bootcamp Week 2

## Working with Ruby

### Bundler
Bundler is a package manager for Ruby. It is the primary way to install Ruby packages (known as gems) for Ruby. 

#### Install Gems
A Gemfile must be created and the gems defined in that file.
```rb
gem 'sinatra'
gem 'rake'
gem 'pry'
gem 'puma'
gem 'activerecord'
```

Then the `bundle install` command must be run. 

This installs the gems on the system globally (unlike node.js which installs packages in a folder called `node_modules`). 

A Gemfile.lock will be created to lock down the gem versions used in this project. 

### Executing Ruby Scripts in the context of bundler

`bundle exec` must be used to tell future ruby scripts tho use the gems the way it was installed, this sets context.

### Sinatra
Sinatra is a micro web framework for Ruby to build web apps. 

It is great for mock or development servers, or for very simple projects. 

A web server can be created in a single file. 

[Sinatra](https://sinatrarb.com/)

## Terratown Mock Server

### Running the web server

The web server can be run by executing the following commands:

```
bundle install
bundle exec ruby server.rb
```

All of the code for the web server is stored in the `server.rb` file. 