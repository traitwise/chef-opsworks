
Chef::Log.info("Executing write_app_data.rb ... ")

node[:deploy].each do |app, deploy|
  configPath = File.join( deploy[:deploy_to], 'current/config' )
  filename = File.join( configPath, filename )
  Chef::Log.info(" --> app data to #{filename}")
  actualPath = File.readlink( configPath )
  Chef::Log.info(" ( this is actually a symlink to the path #{actualPath} )")
  File.open(filename,'w') do |file|
    hash = node[:app_data][app].to_hash
    Chef::Log.info("Contents should be: #{hash.to_yaml}")    
    file.write YAML.dump( hash )
  end
end