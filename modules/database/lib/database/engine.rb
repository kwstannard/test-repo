require 'slim-rails'

module Database
  def self.table_name_prefix = ""

  class Engine < ::Rails::Engine
    isolate_namespace Database

    cattr_accessor :db_config
    self.db_config = YAML.safe_load(
      Engine.root.join("config", "database.yml").read,
      aliases: true,
    )

    config.after_initialize {
      ApplicationRecord.establish_connection(db_config[Rails.env])
    }
  end
end
