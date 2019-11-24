namespace :app_gateway do
  task :create, [:name, :app_type] => [:environment] do |_t, args|
    gateway = AppGateway.create! args.to_h

    puts "API token: #{gateway.token}"
    puts "API secret key: #{gateway.secret_key}"
  end
end
