set :output, 'log/crontab.log'
set :environment, :production

every 1.day, :at => '0:00 am' do
  runner 'User.kuma_schedule'
end
