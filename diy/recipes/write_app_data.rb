
filename = File.join(deploy[:deploy_to], 'current/config', 'app_data.yml')

Chef::Log.info("Writing app data to #{filename}")

node[:deploy].each do |app, deploy|
  File.open(filename,'w') do |file|
    hash = node[:app_data][app].to_hash
    Chef::Log.info("Contents should be: #{hash.to_yaml}")    
    file.write YAML.dump( hash )
  end
end