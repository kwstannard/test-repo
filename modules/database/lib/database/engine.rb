require 'slim-rails'

module Database
  def self.table_name_prefix = ""

  class Engine < ::Rails::Engine
    isolate_namespace Database
    
    # This sets the database configuration from Configuration#database_configuration
    # and then establishes the connection. Avoid referencing ApplicationRecord in this
    # or you can get a dependency loop.
    initializer "database.initialize_database" do
      ActiveSupport.on_load(:active_record) do
        application_config = Rails.application.config.database_configuration
        engine_config = ActiveSupport::ConfigurationFile.parse(Engine.root.join("config", "database.yml"))
        raise 'configs environments wrong' if application_config.keys != engine_config.keys
        self.configurations = application_config.deep_merge(engine_config)
      end
    end

    config.after_initialize { ApplicationRecord }
  end
end
