#
# This recipe is run as part of setup and deploy on a worker instance (which also runs delayed_job workers)
# for the DIY app.  It creates cron entries to run periodic tasks.  
#


#
# The analytics tasks assume that the instance has been configured with the zlab-based tw_stat program 
# which connects to the database and outputs some text files which are then imported back into the DB.
#
# run --simpleTablesOnly analytics, and import anything new
# Every 10 minutes
#
cron 'create_and_import_analytics' do
    user "deploy"
    minute "*/10"
    command '/srv/www/diy_prod/current/user_scripts/create_and_import_fresh_analytics.sh'
end

