env :PATH, ENV['PATH']

job_type :unicorn_start, 'cd :path && bundle exec unicorn -c :path/config/unicorn.rb -E :environment -D'
job_type :rake, 'cd :path && RAILS_ENV=:environment bundle exec rake :task'

every :reboot do
  unicorn_start 'application'
end