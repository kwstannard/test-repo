Rake::Task["db:_dump"].clear
Rake::Task["db:setup"].clear_actions
Rake::Task["db:schema:load"].clear_actions
Rake::Task["db:create"].clear_actions
Rake::Task["db:drop"].clear_actions
Rake::Task["db:migrate"].clear_actions
