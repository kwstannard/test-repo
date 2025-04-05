def wrap_db_task
  og_name = ActiveRecord::Base.connection_specification_name
  og_dir = ActiveRecord::Tasks::DatabaseTasks.db_dir
  puts og_dir
  ActiveRecord::Base.connection_specification_name = "Database::ApplicationRecord"
  ActiveRecord::Tasks::DatabaseTasks.db_dir = Database::Engine.paths['db'].first

  yield

  ActiveRecord::Base.connection_specification_name = og_name
  ActiveRecord::Tasks::DatabaseTasks.db_dir = og_dir
end

desc "Explaining what the task does"
namespace :database do
  task 'drop' => ['environment'] do
    wrap_db_task { ActiveRecord::Tasks::DatabaseTasks.drop_current }
  end

  task 'create' => ['environment'] do
    wrap_db_task { ActiveRecord::Tasks::DatabaseTasks.create_current }
  end

  task 'setup' => ['create'] do
    load(Database::Engine.root.join("db", "schema.rb"))
  end

  task 'migrate' => ['environment'] do
    wrap_db_task {
      ActiveRecord::Tasks::DatabaseTasks.migrate
    }
  end

  task 'prepare' => ['environment'] do
    wrap_db_task {
      ActiveRecord::Tasks::DatabaseTasks.prepare_all
      Database::Engine.instance.load_seed
    }
  end
end

task "db:setup" => ['database:setup']
task "db:migrate" => ['database:migrate']
task "db:prepare" => ['database:prepare']
task "db:drop" => ['database:drop']
