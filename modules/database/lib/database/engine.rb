require 'slim-rails'

module Database
  def self.table_name_prefix = ""

  class Engine < ::Rails::Engine
    isolate_namespace Database
  end
end
