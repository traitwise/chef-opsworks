
Chef::Log.info("Executing write_app_data.rb ... ")

#
# I want to this this file into current/config, but the current symlink has not been
# updated yet to point to this new deploy which has just been placed on disk.  How do
# I get the path to the config folder of the deploy in progress?
#

Chef::Log.info( "The node object contains: #{node.to_hash.to_yaml}")

node[:deploy].each do |app, deploy|
  filename = File.join( deploy[:deploy_to], 'app_data.yml' )
  Chef::Log.info(" --> app data will be written to #{filename}")
  File.open(filename,'w') do |file|
    hash = node[:app_data][app].to_hash
    Chef::Log.info("Contents should be: #{hash.to_yaml}")    
    file.write YAML.dump( hash )
  end

end