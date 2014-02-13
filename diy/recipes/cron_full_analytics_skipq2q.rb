#
# This recipe is run as part of setup and deploy on a worker instance (which also runs delayed_job workers)
# for the DIY app.  It creates cron entries to run periodic tasks.  
#


#
# The analytics tasks assume that the instance has been configured with the zlab-based tw_stat program 
# which connects to the database and outputs some text files which are then imported back into the DB.
#

#
# Run full analytics once overnight.  Will get imported by above.
# 3am
#
cron 'run_full_analytics' do
    user "deploy"
    hour "3"
    minute "0"
    command '/srv/www/diy_prod/current/user_scripts/run_full_twstat_analytics.sh --skipQ2Q'
end


