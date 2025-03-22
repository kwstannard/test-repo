Database::Engine.routes.draw do
  resources(:providers)
  resources(:clients)
  root to: redirect('/database/clients')
end

Rails.application.routes.draw do
  mount Database::Engine => "/database"
end
