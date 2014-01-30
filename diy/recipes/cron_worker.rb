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
    minute "*/10"
    command '/srv/www/diy_prod/user_scripts/create_and_import_fresh_analytics.sh'
end

#
# Run full analytics once overnight.  Will get imported by above.
# 3am
#
# cron 'run_full_analytics' do
#     hour "3"
#     minute "0"
#     command '/srv/www/diy_prod/user_scripts/run_full_twstat_analytics.sh'
# end


# #
# # Delete expired secure iframes 
# # 2am
# #
# cron 'db_housekeeping_iframes' do
#     hour "2"
#     minute "0"
#     command 'cd /srv/www/diy_prod/current; ./script/rails runner -e production /srv/www/diy_prod/current/lib/remove_old_secure_iframes.rb'
# end

# #
# # Every request to a TW other than specific diy_controller pages create anonymous users.  Remove users
# # that are "blank" and of a certain age.
# # 2:10am
# #
# cron 'db_housekeeping_users' do
#     hour "2"
#     minute "10"
#     command => 'cd /srv/www/diy_prod/current; ./script/rails runner -e production /srv/www/diy_prod/current/lib/remove_blank_users.rb'
# end

# #
# # Housekeeping specific to the GA project. Cause database panels (conditions, medications, symptoms) to be asked
# # upon each visit if the user has reported none previously.  
# # 2:20am
# #
# cron 'ga_housekeeping_dbchoose' do
#     hour "2"
#     minute "20"
#     command 'cd /srv/www/diy_prod/current; ./script/rails runner -e production /srv/www/diy_prod/current/lib/clear_blank_dbchoose_responses.rb'
# end


