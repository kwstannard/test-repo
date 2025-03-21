Database::Engine.routes.draw do
  resources(:clients)
  root to: redirect('/database/clients')
end

Rails.application.routes.draw do
  mount Database::Engine => "/database"
end
