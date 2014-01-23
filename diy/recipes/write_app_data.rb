
Chef::Log.info("Executing write_app_data.rb ... ")

#
# I want to this this file into current/config, but the current symlink has not been
# updated yet to point to this new deploy which has just been placed on disk.  How do
# I get the path to the config folder of the deploy in progress?
#

#Chef::Log.info( "The node object contains: #{node.to_hash.to_yaml}")


node[:deploy].each do |app, deploy|
  file File.join(deploy[:deploy_to], 'shared', 'config', 'app_data.yml') do
    content YAML.dump(node[:my_app_data][app].to_hash)
  end
end