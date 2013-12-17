web: bundle exec unicorn -p $PORT -c ./config/unicorn.rb
auth-server: sh -c 'cd ../devise_authentication_api && bundle exec rackup -p 9393'
backend-api: sh -c 'cd ../opg-lpa-api && auth_service_url=http://localhost:9393  bundle exec rackup -p 9292'
sidekiq: sh -c 'bundle exec sidekiq'
