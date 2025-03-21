require 'slim-rails'

module Database
  class Engine < ::Rails::Engine
    isolate_namespace Database
  end
end
