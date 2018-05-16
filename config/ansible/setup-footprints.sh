git clone https://github.com/thomasythuang/footprints-public.git
sudo -u postgres createuser -s pguser
sudo -u postgres psql -U postgres -d postgres -c "alter user pguser with password 'password';"
source /usr/local/rvm/scripts/rvm
rvm use 2.2.9 --default
cd footprints-public
gem install bundler
bundle install
sudo chmod 777 -R /home/ubuntu/footprints-public
RAILS_ENV=production bundle exec rake db:setup
RAILS_ENV=production bundle exec rake assets:precompile db:migrate
sudo chmod 777 /home/ubuntu/footprints-public/tmp
sudo chmod 777 /home/ubuntu/footprints-public/app
RAILS_ENV=production bundle exec rake assets:precompile
