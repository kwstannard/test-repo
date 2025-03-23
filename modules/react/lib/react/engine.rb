module React
  class Engine < ::Rails::Engine
    isolate_namespace React

    paths['public'] = self.root.join("public")

    initializer("#{self} static assets") {
      Rails.application.middleware.use(
        ::ActionDispatch::Static,
        paths['public'].first,
        index: Rails.application.config.public_file_server.index_name,
        headers: Rails.application.config.public_file_server.headers
      )
    }

    if %w(test development).include?(Rails.env)
      initializer("watch assets") do
        pid = Process.spawn("npm run watch")

        at_exit { puts 'waiting on esbuild watch'; Process.wait(pid) && puts('watch ended') }
      end
    end
  end
end
