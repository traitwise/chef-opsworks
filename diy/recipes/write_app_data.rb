
Chef::Log.info("Executing write_app_data.rb ... ")

#
# I want to this this file into current/config, but the current symlink has not been
# updated yet to point to this new deploy which has just been placed on disk.  How do
# I get the path to the config folder of the deploy in progress?
#

#Chef::Log.info( "The node object contains: #{node.to_hash.to_yaml}")

Chef::Log.info( "*** WAD")
Chef::Log.info( "node[:app_data] is #{node[:app_data].to_hash.to_yaml}" ) if node[:app_data]


node[:deploy].each do |app, deploy|
  Chef::Log.info( "*** WAD")
  path = '#{deploy[:deploy_to]}/shared/config'
  shared_exists = File.exist? path
  Chef::Log.info( "The path #{path} exists -> #{shared_exists}")

  Chef::Log.info( "*** WAD")
  Chef::Log.info( "app is #{app.to_s}")
  Chef::Log.info( "*** WAD")
  Chef::Log.info( "deploy is #{deploy.to_hash.to_yaml}")



  if node[:app_data][app]
    Chef::Log.info( "*** WAD")
    Chef::Log.info( "Writing to #{deploy[:deploy_to]}/shared/config/app_data.yml app_data: #{node[:app_data][app].to_hash.to_yaml}")

    file File.join(deploy[:deploy_to], 'shared', 'config', 'app_data.yml') do
      content YAML.dump(node[:app_data][app].to_hash)
    end
  end

  Chef::Log.info( "*** WAD")
  path = '#{deploy[:deploy_to]}/shared/config/app_data.yml'
  shared_exists = File.exist? path
  Chef::Log.info( "The path #{path} exists -> #{shared_exists}")

end