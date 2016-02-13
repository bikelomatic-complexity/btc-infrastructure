#
# Cookbook Name:: btc-infrastructure
# Recipe:: nodejs_deploy
#
# Author:: Steven Kroh
#
# Copyright 2016, Adventure Cycling Association

# The app name we're expecting to deploy
app_name = node['server']['name']

# Only deply if the incoming app name matches our expected app name
deploy = node['deploy'][app_name]

if deploy
  # Install nssm, so we can wrap the app server in a Windows service
  include_recipe 'nssm'

  # Ensure the app server pulls the production configuration
  env 'NODE_ENV' do
    value deploy['environment_variables']['NODE_ENV']
  end

  env 'SERVER_SECRET' do
    value deploy['environment_variables']['SERVER_SECRET']
  end

  env 'SERVER_JWT_EXP' do
    value deploy['environment_variables']['SERVER_JWT_EXP']
  end

  # The app servers' directory in the global node_modules
  app_dir = File.join(ENV['AppData'], 'npm', 'node_modules', app_name)

  # We re-purpose the AWS OpsWorks App "document root" field to mean the
  # javascript file within the npm package to run, usualy `path/to/index.js`
  script = deploy['deploy_to']

  # Pay attention! The next few resources are out of logical order. We execute
  # them in the right order by chaining notifications.

  # First, install the service with nssm.cc, even though the javascript file
  # referenced by the `script` variable MAY NOT EXIST yet. We need the
  # Windows service to exist so we can use the :stop action regardless if
  # this is the first or a subsequent chef run.
  nssm app_name do
    program node['nodejs']['node.exe']
    args File.join(app_dir, script)
    params(
      AppDirectory: app_dir,
      AppStdout: File.join(app_dir, 'service.log'),
      AppStderr: File.join(app_dir, 'error.log'),
      AppRotateFiles: 1
    )
    start false
    action :install
  end

  # Define the powershell script to install our app server tarball. However,
  # do nothing! If the tarball changes (below), it will notify us to install
  # the changes. In addition, when the install completes, run the service.
  powershell_script 'install_app' do
    code "npm install -g --loglevel error #{app_name}.tgz"
    cwd Chef::Config[:file_cache_path]
    notifies :start, "service[#{app_name}]"
    action :nothing
  end

  # When the app server tarball updates, stop the windows service, so we can
  # then run the installer.
  remote_file File.join(Chef::Config[:file_cache_path], "#{app_name}.tgz") do
    source deploy['scm']['repository']
    action :create
    notifies :stop, "service[#{app_name}]"
    notifies :run, 'powershell_script[install_app]'
  end

  # Ensure the service is enabled, so that it will start on boot
  service app_name do
    action :enable
  end
end
