#
# This recipe is run as part of setup and deploy on a worker instance (which also runs delayed_job workers)
# for the DIY app.  It creates cron entries to run periodic tasks.  

#
# NOTE: this is not currently run on DIY.  It seems you have to create separate recipes for each
# cron task?  wtf.  Keeping this incase I figure out how to do it with one file.
#


#
# backup database at top of every hour (2min after to allow most recent import to occur first).
# This should be done from the read-replica to avoid bogging down IO on the master.
#
cron 'backup_database' do
    user "deploy"
    minute "2"
    command '/srv/www/diy_prod/current/user_scripts/backup_databases.sh'
end

