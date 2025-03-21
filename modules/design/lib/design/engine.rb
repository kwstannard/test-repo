require "slim-rails"

module Design
  class Engine < ::Rails::Engine
    isolate_namespace Design
  end
end
