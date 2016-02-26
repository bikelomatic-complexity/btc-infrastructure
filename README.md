# Description

[![Build Status](https://travis-ci.org/bikelomatic-complexity/btc-infrastructure.svg?branch=master)](https://travis-ci.org/bikelomatic-complexity/btc-infrastructure)

Configures Windows Server instances to run the Bicycle Touring Companion application and infrastructure

# Requirements

## Platform:

* windows

## Cookbooks:

* netsh_firewall (>= 0.3.2)
* nssm (~> 1.2.0)

# Attributes

* `node['admin_users']` - Array of admin users as {:username, :password} hashes. Defaults to `[ ... ]`.
* `node['server']['name']` -  Defaults to `btc-app-server`.

# Recipes

* btc_infrastructure::couchdb
* btc_infrastructure::couchdb_bootstrap
* btc_infrastructure::default
* btc_infrastructure::git
* btc_infrastructure::nodejs
* btc_infrastructure::nodejs_configure
* btc_infrastructure::nodejs_deploy

# Development
## On your own machine
This project is a Chef cookbook. It is used to provision our EC2 instances to support the Bicyle Touring Companion app. To learn
move about chef, be sure to visit [the Chef website](https://docs.chef.io/index.html).

This repository is written primarily in Ruby. Therefore, you will need to install Ruby. You will also need to install Bundler.

 - `$ gem install bundler`

After you clone this repository, make sure to install all the required gems.

 - `$ bundle install`

This cookbook is set up with [Test Kitchen](http://kitchen.ci) integration
tests. While you develop, it will be useful to test the Chef code on a virtual
instance of Windows Server 2012 R2. To do this, install both VirtualBox (a 4.x
release) and vagrant. Then, add the [`mwrock/Windows2012R2` ](https://atlas.hashicorp.com/mwrock/boxes/Windows2012R2) box.
 - `$ vagrant box add mwrock/Windows2012R2`

Before you do anything else: Run this, to generate the `.kitchen.yml`:
 - `$ bundle exec rake merge`

Then, you can issue these Test Kitchen commands:

 - `$ kitchen create` will create VirtualBox vm's for each test suite
 - `$ kitchen converge` will run our chef recipes on the vm's
 - `$ kitchen verify` will run our integration tests on the instances
 - `$ kitchen test` will perform the above the above three steps in one go, but it will run very slow.
 - `$ kitchen destroy` will remove the vm's from your machine

You can be more specific with the above commands:

 - `$ kitchen create couchdb` will only create a vm for the CouchDB suite. Do this if you are only working on CouchDB related improvements.

## Continuous Integration
Test kitchen is set to run on Travis. However, EC2 instances are used. In order
for this to work, a number of environment variables must be set in
`.travis.yml`. In addition, these environment variables must be encrypted,
since Travis builds are made public for open source projects. Only perform
these next steps when you want to change the AWS keys backing the integration.

 - `$ travis encrypt AWS_ACCESS_KEY_ID="${YOUR_KEY_ID_HERE}" --add`
 - `$ travis encrypt AWS_SECRET_ACCESS_KEY="${YOUR_SECRET_KEY_HERE}" --add`

In order for Test Kitchen to retrieve the Administrator password for the
generated EC2 instances, you must also supply an EC2 keypair.

 - `$ travis encrypt AWS_KEY_PAIR_NAME="${YOUR_KEYPAIR_NAME_HERE}" --add`
 - `$ travis encrypt-file "${YOUR_KEYPAIR_PEM}" --add`

### A note on `kitchen-ec2`
`kitchen-ec2` has a default bootstrap script to ensure EC2 instances are
ready to run chef remotely. Unfortunately, we are encountering an issue with
Powershell execution policy. So, we've written our own bootstrap script to
enable Powershell execution. That file is `.kitchen.cloud.bootstrap`.

### A note on instance price
Spot instances are used to run the integration tests. This cuts EC2 price in
half. We store the desired spot price in an encrypted travis environment
variable.

## Rake Tasks
Before submitting PRs to this project, make sure you run any applicable style
checks, unit tests, and integration tests.

 - `$ bundle exec rake style` to run Chef's foodcritic and eventually rubocop.
 - `$ bundle exec rake doc` to generate this `README.md`


# License and Maintainer

Maintainer:: Adventure Cycling Association (<sk.kroh@gmail.com>)
Source:: https://github.com/bikelomatic-complexity/btc-infrastructure
Issues:: https://github.com/bikelomatic-complexity/btc-infrastructure/issues

License:: AGPL v3
