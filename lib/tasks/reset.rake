namespace :reset do
 desc "Rebuild system"
 task :build => ["tmp:clear", "log:clear", "db:drop", "db:create", "db:migrate"]
 task :rebuild => [ "db:seed", "setup:user", "cron:channel_setup" ]
end
