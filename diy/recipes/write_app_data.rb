
Chef::Log.info( "In write_app_data.rb...")

me = `whoami`
Chef::Log.info("Executing write_app_data.rb as #{me}... ")

#
# I want to this this file into current/config, but the current symlink has not been
# updated yet to point to this new deploy which has just been placed on disk.  How do
# I get the path to the config folder of the deploy in progress?
#

node[:deploy].each do |app, deploy|
  if node[:app_data][app]
    #
    # Ensure the shared/config folder exists for this app since on DJ workers without 
    # all the normal rails recipes it may not...
    #
    directory "#{deploy[:deploy_to]}/shared/config" do
      owner "deploy"
      group "www-data"
      mode 0774
      recursive true
      action :create
    end

    Chef::Log.info( "Writing to #{deploy[:deploy_to]}/shared/config/app_data.yml app_data: #{node[:app_data][app].to_hash.to_yaml}")

    file File.join(deploy[:deploy_to], 'shared', 'config', 'app_data.yml') do
      content YAML.dump(node[:app_data][app].to_hash)
    end
  end
end