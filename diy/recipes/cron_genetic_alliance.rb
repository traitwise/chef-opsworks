#
# This recipe is run as part of setup and deploy on a worker instance (which also runs delayed_job workers)
# for the DIY app.  It creates cron entries to run periodic tasks.  
#

#
# Housekeeping specific to the GA project. Cause database panels (conditions, medications, symptoms) to be asked
# upon each visit if the user has reported none previously.  
# 2:20am
#
cron 'ga_housekeeping_dbchoose' do
  user "deploy"
  hour "8"
  minute "20"
  command 'cd /srv/www/diy_prod/current; ./script/rails runner -e production /srv/www/diy_prod/current/lib/clear_blank_dbchoose_responses.rb'
end


