
Chef::Log.info("Executing write_app_data.rb ... ")

node[:deploy].each do |app, deploy|
  filename = File.join(deploy[:deploy_to], 'current', 'app_data.yml')
  Chef::Log.info(" --> app data to #{filename}")
  File.open(filename,'w') do |file|
    hash = node[:app_data][app].to_hash
    Chef::Log.info("Contents should be: #{hash.to_yaml}")    
    file.write YAML.dump( hash )
  end
end