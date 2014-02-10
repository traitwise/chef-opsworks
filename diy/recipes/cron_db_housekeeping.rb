#
# This recipe is run as part of setup and deploy on a worker instance (which also runs delayed_job workers)
# for the DIY app.  It creates cron entries to run periodic tasks.  
#

#
# Housekeeping specific to the GA project. Cause database panels (conditions, medications, symptoms) to be asked
# upon each visit if the user has reported none previously.  
# 2:10am
#
cron 'db_housekeeping' do
    user "deploy"
    hour "8"
    minute "10"
    command 'cd /srv/www/diy_prod/current; rake database_housekeeping'
end

