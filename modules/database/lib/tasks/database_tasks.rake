desc "Explaining what the task does"
namespace :database do
  _db_conf = -> {
    Database::Engine.db_config[Rails.env]
  }

  task :establish_db_connection do
    ActiveRecord::Base.establish_connection(_db_conf.())
  end

  task 'drop' => ['environment'] do
    ActiveRecord::Tasks::DatabaseTasks.drop(_db_conf.())
  end

  task 'create' => ['environment'] do
    ActiveRecord::Tasks::DatabaseTasks.create(_db_conf.())
  end

  task 'setup' => ['create', 'establish_db_connection'] do
    load(Database::Engine.root.join("db", "schema.rb"))
  end

  task 'migrate' => ['establish_db_connection'] do
    ActiveRecord::Tasks::DatabaseTasks.migrate
  end
end

task "db:setup" => ['database:setup']
task "db:migrate" => ['database:migrate']
