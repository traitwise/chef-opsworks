
Chef::Log.info("Executing write_app_data.rb ... ")

node[:deploy].each do |app, deploy|
  configPath = File.join( deploy[:deploy_to], 'current/config' )
  filename = File.join( configPath, 'app_data.yml' )
  Chef::Log.info(" --> app data will be written to #{filename}")
  File.open(filename,'w') do |file|
    hash = node[:app_data][app].to_hash
    Chef::Log.info("Contents should be: #{hash.to_yaml}")    
    file.write YAML.dump( hash )
  end

  actualPath = File.readlink( filename )
  Chef::Log.info(" ( this is actually a symlink to the path #{actualPath} )")

end