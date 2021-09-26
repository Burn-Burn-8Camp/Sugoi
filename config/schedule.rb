# set :output, "/path/to/my/cron_log.log"
#
every 1.minute do
  rake "orders:run"
end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end
