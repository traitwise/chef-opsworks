Chef::Log.info("Writing app data to app_data.yml")

node[:deploy].each do |app, deploy|
  File.open(File.join(deploy[:deploy_to], 'current/app/config', 'app_data.yml'),'w') do |file|
    file.write YAML.dump(node[:app_data][app].to_hash)
  end
end