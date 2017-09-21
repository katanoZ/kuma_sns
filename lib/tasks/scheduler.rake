desc "This task is called by the Heroku scheduler add-on"
task :action_one => :environment do
  User.kuma_schedule
end
